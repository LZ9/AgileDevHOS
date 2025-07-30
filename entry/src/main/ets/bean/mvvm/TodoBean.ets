/**
 * 代办数据实体
 * Created by zhouL on 2025/7/29.
 */
@Observed
export class TodoBean {
  /** 编号 */
  @Track public "id": string = "002"
  /** 标题 */
  @Track public "title": string = ""
  /** 是否完成 */
  @Track public "isFinish": boolean = false
}
