import { BusinessError } from "@kit.BasicServicesKit"

/**
 * 数据异常包裹类
 * Created by zhouL on 2025/7/29.
 */
export class DataError<T> implements BusinessError<T> {
  public code: number
  public data?: T
  public name: string
  public message: string
  public stack?: string

  constructor(code: number, data?: T, e?: Error) {
    this.code = code
    this.data = data
    this.message = e?.message ?? "数据异常"
    this.name = e?.name ?? "DataError"
    this.stack = e?.stack
  }
}
