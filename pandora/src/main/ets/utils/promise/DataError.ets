/**
 * 数据异常包裹类
 * Created by zhouL on 2025/7/29.
 */
export class DataError<T> extends Error {
  /** 异常数据 */
  public data: T | null = null

  constructor(data: T | null, message?: string, name?: string, stack?: string) {
    super();
    this.data = data;
    this.message = message ?? "数据异常";
    this.name = name ?? "DataError";
    this.stack = stack;
  }
}
