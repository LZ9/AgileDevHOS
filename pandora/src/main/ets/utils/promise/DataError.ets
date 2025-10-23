import { StringUtils } from "../../../../../Index"
import { ResponseContract } from "./ResponseContract"

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

  /**
   * 获取提示语
   * @param defTips 默认提示语
   */
  public getTips(defTips?: string): string {
    if (this.data !== undefined && this.data instanceof ResponseContract) {
      return StringUtils.isEmpty(this.data.valueMsg()) ? (defTips ?? this.message) : this.data.valueMsg()
    }
    return this.message
  }
}
