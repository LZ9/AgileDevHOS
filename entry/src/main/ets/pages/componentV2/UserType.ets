/**
 * 用户类型
 * Created by zhouL on 2025/8/4.
 */
export class UserType {
  code: number
  city: string

  constructor(code: number, city: string) {
    this.code = code;
    this.city = city;
  }
}