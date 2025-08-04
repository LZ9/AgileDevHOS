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
}