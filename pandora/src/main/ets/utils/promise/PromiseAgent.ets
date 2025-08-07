import { DataError } from "./DataError"
import { Disposable } from "./Disposable"
import { Observer } from "./Observer"
import { ResponseContract } from "./ResponseContract"

/**
 * Promise扩展
 * Created by zhouL on 2025/7/29.
 */
export class PromiseAgent<T extends Object> implements Disposable {
  /** 外部Promise代码块 */
  private block?: (controller: Disposable) => Promise<T> | undefined
  /** 是否终止 */
  private isStop: boolean = false

  private constructor() {
  }

  /** 创建Promise代理 */
  public static create<T extends Object>(): PromiseAgent<T> {
    return new PromiseAgent<T>()
  }

  /**
   * 创建Promise对象
   * @param t 数据
   */
  public static just<T>(t?: T): Promise<T | undefined> {
    return Promise.resolve(t)
  }

  /**
   * 执行外部Promise代码块
   * @param block 代码块
   */
  public then(block: (controller: Disposable) => Promise<T>): PromiseAgent<T> {
    this.block = block
    return this
  }

  /** 任务是否终止 */
  public isDisposed(): boolean {
    return this.isStop
  }

  /** 终止任务 */
  public dispose(): void {
    this.isStop = true
  }

  /**
   * 订阅Promise结果（返回生命周期控制器）
   * @param observer 观察者
   */
  public subscribe(observer?: Observer<T>): Disposable {
    PromiseAgent.just<T>()
      .then((t) => {
        if (observer && observer.onSubscribe) {
          observer.onSubscribe() //订阅前回调
        }
        return t
      })
      .then((t) => {
        if (this.block) {
          return this.block(this) // 执行自定义Promise
        }
        return PromiseAgent.just(t)
      })
      .then((t) => {
        if (this.isDisposed()) {//如果已终止就不再执行回调
          return
        }
        if (t === undefined) {
          if (observer && observer.onError) {
            observer.onError(new DataError<T>(0, t, new Error("返回数据为undefined")))
          }
          return
        }
        if (t instanceof ResponseContract) {
          if (!t.isSuccess()) { // 预判接口请求是否成功
            if (observer && observer.onError) {
              observer.onError(new DataError<T>(t.valueCode(), t, new Error(t.valueMsg())))
            }
            return
          }
        }
        if (observer) {
          observer.onNext(t) // 数据返回成功回调
        }
      })
      .catch((e: Error) => {
        if (this.isDisposed()) {
          return
        }
        if (observer && observer.onError) {
          let err = new DataError<T>(0, undefined, e)
          if (e instanceof DataError) {
            err = e
          }
          observer.onError(err) // 订阅报错回调
        }
      })
      .finally(() => {
        if (this.isDisposed()) {
          return
        }
        if (observer && observer.onFinally) {
          observer.onFinally() // 订阅结束回调
        }
      })
    return this
  }
}