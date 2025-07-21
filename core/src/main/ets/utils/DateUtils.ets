/**
 * 日期工具类
 * Created by zhouL on 2025/7/21.
 */
export class DateUtils {

  /**
   * 获取当前时间指定日期格式的字符串
   * @param format 日期格式，例如 CoreConstants.DateFormat.TYPE_1
   */
  public static getCurrentFormatString(format: string): string {
    return DateUtils.getFormatString(format, new Date())
  }

  /**
   * 获取指定日期和格式的字符串
   * @param format 日期格式，例如 CoreConstants.DateFormat.TYPE_1
   * @param date 日期对象
   */
  public static getFormatString(format: string, date: Date | number): string {
    const d = date instanceof Date ? date : new Date(date)
    const padStart = (num: number) => num.toString().padStart(2, '0')

    const year = d.getFullYear()
    const month = padStart(d.getMonth() + 1) // 月份从0开始需+1
    const day = padStart(d.getDate())
    const hours = padStart(d.getHours())
    const minutes = padStart(d.getMinutes())
    const seconds = padStart(d.getSeconds())
    const milliseconds = d.getMilliseconds().toString().padStart(3, '0')

    // 通过映射表替换格式符
    return format
      .replace('yyyy', year.toString())
      .replace('MM', month)
      .replace('dd', day)
      .replace('HH', hours)
      .replace('mm', minutes)
      .replace('ss', seconds)
      .replace('SSS', milliseconds)
  }

  /**
   * 解析日期字符串
   * @param date 日期字符串
   * @param format 日期格式，例如 CoreConstants.DateFormat.TYPE_1
   */
  public static parse(date: string, format: string): Date {
    const d = new Date()
    d.setFullYear(DateUtils.getValue(date, DateUtils.getIndex(format, 'yyyy')))
    d.setMonth(DateUtils.getValue(date, DateUtils.getIndex(format, 'MM')) - 1)
    d.setDate(DateUtils.getValue(date, DateUtils.getIndex(format, 'dd')))
    d.setHours(DateUtils.getValue(date, DateUtils.getIndex(format, 'HH')))
    d.setMinutes(DateUtils.getValue(date, DateUtils.getIndex(format, 'mm')))
    d.setSeconds(DateUtils.getValue(date, DateUtils.getIndex(format, 'ss')))
    d.setMilliseconds(DateUtils.getValue(date, DateUtils.getIndex(format, 'SSS')))
    return d
  }

  /**
   * 获取日期格式中目标字符位置的索引
   * @param src 日期格式
   * @param target 目标字符
   */
  private static getIndex(format: string, target: string): Record<number, number> {
    const start = format.indexOf(target)
    if (start === -1) {
      return [start, -1]
    }
    return [start, start + target.length]
  }

  /**
   * 获取日期字符串中的目标字符
   * @param date 日期字符串
   * @param record 目标字符索引
   */
  private static getValue(date: string, index: Record<number, number>): number {
    if (index[0] !== -1) {
      return parseInt(date.substring(index[0], index[1]))
    }
    return 0
  }

}

