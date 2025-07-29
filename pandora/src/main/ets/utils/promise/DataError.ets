/**
 * 数据异常包裹类
 * Created by zhouL on 2025/7/29.
 */
export class DataError<T> extends Error {
  /** 异常数据 */
  public data: T | null = null

  constructor(data: T | null,name?: string, message?: string, stack?: string) {
    super();
    this.data = data;
    this.name = name ?? this.name;
    this.message = message ?? "数据异常";
    this.stack = stack;
  }
}
