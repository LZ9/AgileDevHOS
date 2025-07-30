import { DataError } from "./DataError"
import { ProObserver } from "./ProObserver"
import { ResponseContract } from "./ResponseContract"

/**
 * Promise扩展
 * Created by zhouL on 2025/7/29.
 */
export class PromiseAgent<T extends  Object> {
  private observer?: ProObserver<T> | undefined
  private block?: () => Promise<T> | undefined

  private constructor() {
  }

  public static create<T extends  Object>(): PromiseAgent<T> {
    return new PromiseAgent<T>()
  }

  public static just<T>(t?: T): Promise<T | undefined> {
    return Promise.resolve(t)
  }

  public then(block: () => Promise<T>): PromiseAgent<T> {
    this.block = block
    return this
  }

  public run(observer?: ProObserver<T>) {
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
        if (t !== undefined) {
          if (t instanceof ResponseContract) {
            if (!t.isSuccess()) { // 预判接口请求是否成功
              if (this.observer && this.observer.onError) {
                this.observer.onError(new DataError<T>(t, t.valueStatus(), t.valueMsg(), ""))
              }
              return
            }
          }
          if (this.observer) {
            this.observer.onNext(t) // 数据返回成功回调
          }
          return
        }
        if (this.observer && this.observer.onError) {
          this.observer.onError(new DataError<T>(null, "undefined", "返回数据undefined", ""))
        }
      })
      .catch((e: Error) => {
        if (this.observer && this.observer.onError) {
          this.observer.onError(new DataError<T>(null, e.name, e.message, e.stack)) // 订阅报错回调
        }
      })
      .finally(() => {
        if (this.observer && this.observer.onFinally) {
          this.observer.onFinally() // 订阅结束回调
        }
      })
  }
}