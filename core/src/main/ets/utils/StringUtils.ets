/**
 * 字符串工具类
 * Created by zhouL on 2025/7/13.
 */
export class StringUtils {
  /**
   * 字符串是否为空
   * @param str 字符串
   */
  public static isEmpty(str: string | undefined | null): boolean {
    return str === undefined || str === null || str.length === 0
  }
}

