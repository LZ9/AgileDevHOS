import { DataError } from "../../../../../Index"

/**
 * PromiseAgent的观察者
 * Created by zhouL on 2025/7/29.
 */
export interface ProObserver<T> {
  /** 订阅前 */
  onSubscribe?: () => void
  /** 订阅结果回调 */
  onNext: (t: T) => void
  /** 订阅失败 */
  onError?: (e: DataError<T>) => void
  /** 订阅结束 */
  onFinally?: () => void
}
