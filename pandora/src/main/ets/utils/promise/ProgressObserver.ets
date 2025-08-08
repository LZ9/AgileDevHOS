import { Observer } from "./Observer"

/**
 * PromiseAgent的加载框观察者
 * Created by zhouL on 2025/8/7.
 */
export interface ProgressObserver<T> extends Observer<T> {

  /** 加载框关闭回调 */
  onPgCancel?: () => void
}
