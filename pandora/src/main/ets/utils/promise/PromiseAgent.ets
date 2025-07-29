import { DataError } from "../../../../../Index"
import { ProObserver } from "./ProObserver"

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
          this.observer.onSubscribe()
        }
        return t
      })
      .then((t) => {
        if (this.block) {
          return this.block()
        }
        return PromiseAgent.just(t)
      })
      .then((t) => {
        if (t !== undefined) {
          if (this.isResponseStatus(t)) {
            const isSuccess = Reflect.get(t, 'isSuccess')
            if (typeof isSuccess === `function`) {
              const fn = isSuccess as Function


              const res = fn() as boolean
              let a = 1
            }

          }
          if (this.observer) {
            this.observer.onNext(t)
          }
          return
        }
      })
      .catch((e: Error) => {
        if (this.observer && this.observer.onError) {
          this.observer.onError(new DataError<T>(null, e.name, e.message, e.stack))
        }
      })
      .finally(() => {
        if (this.observer && this.observer.onFinally) {
          this.observer.onFinally()
        }
      })
  }

  isResponseStatus(obj: T): boolean {
    const valueMsg = Reflect.get(obj, 'valueMsg')
    const valueStatus = Reflect.get(obj, 'valueStatus')
    return valueMsg !== undefined && valueStatus !== undefined
  }
}