import { DataError } from "./DataError"
import { Observer } from "./Observer"
import { ResponseContract } from "./ResponseContract"

/**
 * Promise扩展
 * Created by zhouL on 2025/7/29.
 */
export class PromiseAgent<T extends  Object> {
  private observer?: Observer<T> | undefined
  private block?: () => Promise<T> | undefined

  private constructor() {
  }

  /** 创建Promise代理 */
  public static create<T extends  Object>(): PromiseAgent<T> {
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
  public then(block: () => Promise<T>): PromiseAgent<T> {
    this.block = block
    return this
  }

  /**
   * 订阅Promise结果
   * @param observer 观察者
   */
  public subscribe(observer?: Observer<T>) {
    this.observer = observer
    PromiseAgent.just<T>()
      .then((t) => {
        if (this.observer && this.observer.onSubscribe) {
          this.observer.onSubscribe() //订阅前回调
        }
        return t
      })
      .then((t) => {
        if (this.block) {
          return this.block() // 执行自定义Promise
        }
        return PromiseAgent.just(t)
      })
      .then((t) => {
        if (t === undefined) {
          if (this.observer && this.observer.onError) {
            this.observer.onError(new DataError<T>(null, "返回数据undefined"))
          }
          return
        }
        if (t instanceof ResponseContract) {
          if (!t.isSuccess()) { // 预判接口请求是否成功
            if (this.observer && this.observer.onError) {
              this.observer.onError(new DataError<T>(t, t.valueMsg()))
            }
            return
          }
        }
        if (this.observer) {
          this.observer.onNext(t) // 数据返回成功回调
        }
      })
      .catch((e: Error) => {
        if (this.observer && this.observer.onError) {
          let err = new DataError<T>(null, e.message, e.name, e.stack)
          if (e instanceof DataError) {
            err = e
          }
          this.observer.onError(err) // 订阅报错回调
        }
      })
      .finally(() => {
        if (this.observer && this.observer.onFinally) {
          this.observer.onFinally() // 订阅结束回调
        }
      })
  }
}