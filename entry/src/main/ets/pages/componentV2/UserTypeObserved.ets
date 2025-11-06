import { PrintLog } from "@lodz/pandora";
import { Constants } from "../../config/Constants";

/**
 * 用户类型（观察者装饰器）
 * Created by zhouL on 2025/8/4.
 */
@ObservedV2
export class UserTypeObserved {
  @Trace public id: number
  @Trace public name: string
  public onFieldChangedListener?: (monitor: IMonitor) => void

  constructor(id: number, name: string, listener?: (monitor: IMonitor) => void) {
    this.id = id
    this.name = name
    this.onFieldChangedListener = listener
  }

  @Monitor(`id`,`name`)
  handle(monitor: IMonitor) {
    if (this.onFieldChangedListener !== undefined) {
      this.onFieldChangedListener(monitor)
    }
  }
}