import { PrintLog } from "@lodz/pandora";
import { Constants } from "../../config/Constants";

/**
 * 用户类型（观察者装饰器）
 * Created by zhouL on 2025/8/4.
 */
@ObservedV2
export class UserTypeObserved {
  @Trace id: number
  @Trace name: string

  constructor(id: number, name: string) {
    this.id = id;
    this.name = name;
  }

  @Monitor(`id`,`name`)
  handle(monitor: IMonitor) {
    PrintLog.i(Constants.Log.TAG, "被修改的变量名称 : " + monitor.value()?.path)
    PrintLog.i(Constants.Log.TAG, "被修改的变量之前的值 : " + monitor.value()?.before)
    PrintLog.i(Constants.Log.TAG, "被修改的变量现在的值 : " + monitor.value()?.now)
  }
}