/**
 * 键值对结构
 * Created by zhouL on 2025/10/11.
 */
export class KVBean {
  public key: string = ""
  public value: string = ""

  constructor(key: string, value: string) {
    this.key = key
    this.value = value
  }
}