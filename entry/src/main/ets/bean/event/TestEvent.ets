/**
 * 测试事件
 * Created by zhouL on 2025/10/29.
 */
export class TestEvent {
  public content: string
  public date?: Date

  constructor(content: string, date?: Date) {
    this.content = content
    this.date = date
  }
}