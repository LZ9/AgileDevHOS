import { buffer, util } from "@kit.ArkTS"

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

  /**
   * 字符串转数字
   * @param str 字符串
   */
  public static toNumber(str: string | undefined | null): number {
    return parseInt(str ?? '-1')
  }

  /**
   * Uint8Array转字符串
   * @param src 数据源
   * @param encoding 编码，默认utf-8
   */
  public static unit8ArrayToStr(src: Uint8Array, encoding: buffer.BufferEncoding = 'utf-8'): string {
    return util.TextDecoder.create(encoding, { ignoreBOM: true }).decodeToString(src, { stream: true })
  }

  /**
   * 字符串转Uint8Array
   * @param src 数据源
   * @param encoding 编码，默认utf-8
   */
  public static strToUint8Array(src: string, encoding: buffer.BufferEncoding = 'utf-8'): Uint8Array {
    return new util.TextEncoder(encoding).encodeInto(src)
  }

  /**
   * 字符串忽略大小写比较
   * @param first 字符串
   * @param second 字符串
   */
  public static equalsIgnoreCase(first: string, second: string): boolean {
    return first.toLowerCase() === second.toLowerCase();
  }
}

