/**
 * 代办数据实体
 * Created by zhouL on 2025/7/29.
 */
@ObservedV2
export class TodoBean {
  /** 编号 */
  @Trace public "id": string = "002"
  /** 标题 */
  @Trace public "title": string = ""
  /** 是否完成 */
  @Trace public "isFinish": boolean = false
}
