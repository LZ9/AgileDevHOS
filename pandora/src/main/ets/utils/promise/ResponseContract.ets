/**
 * 接口数据状态
 * Created by zhouL on 2025/7/30.
 */
export abstract class ResponseContract {
  /** 数据是否返回成功 */
  public abstract isSuccess(): boolean

  /** 获取提示语信息 */
  public abstract valueMsg(): string

  /** 获取状态码 */
  public abstract valueCode(): number
}