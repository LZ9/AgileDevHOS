/**
 * Record数据对象
 * Created by zhouL on 2025/9/19.
 */
export class RecordData<V> {
  /** 键 */
  public key: string | number
  /** 值 */
  public value: V

  constructor(key: string | number, value: V) {
    this.key = key
    this.value = value
  }
}