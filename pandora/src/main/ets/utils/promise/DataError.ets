/**
 * 数据异常包裹类
 * Created by zhouL on 2025/7/29.
 */
export class DataError<T> extends Error {
  public code: number
  public data?: T

  constructor(code: number, data?: T, message?: string) {
    super(message)
    this.code = code
    this.data = data
  }
}
