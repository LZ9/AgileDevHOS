/**
 * 键值对结构
 * Created by zhouL on 2025/10/11.
 */
export class KVBean {
  public key: string = ""
  public value: string = ""

  private constructor(key: string, value: string) {
    this.key = key
    this.value = value
  }

  public static create(key: string, value: string): KVBean {
    return new KVBean(key, value)
  }
}