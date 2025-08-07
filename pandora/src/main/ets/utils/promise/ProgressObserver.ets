import { DataError } from "./DataError"
import { Observer } from "./Observer"

/**
 * PromiseAgent的加载框观察者
 * Created by zhouL on 2025/8/7.
 */
export class ProgressObserver<T> implements Observer<T> {

  public onSubscribe: (() => void) | undefined = () => {

  }
  public onNext: (t: T) => void = (t: T) => {

  }
  public onError: ((e: DataError<T>) => void) | undefined = () => {

  }
  public onFinally: (() => void) | undefined = () => {

  }
}
