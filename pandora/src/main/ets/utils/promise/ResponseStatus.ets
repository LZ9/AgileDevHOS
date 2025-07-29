/**
 * 接口数据状态
 * Created by zhouL on 2025/7/29.
 */
export interface ResponseStatus {
  /** 数据是否返回成功 */
  isSuccess(): boolean

  /** 获取提示语信息 */
  valueMsg(): String

  /** 获取状态标志 */
  valueStatus(): String
}

