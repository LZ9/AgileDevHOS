import { util } from "@kit.ArkTS"

/**
 * 数字格式化工具类
 * Created by zhouL on 2025/10/17.
 */
export class NumberFormatUtils {

  /**
   * 格式化数字
   * @param value 小数
   * @param digits 小数位数（默认2，0 <= digits <= 20）
   */
  public static format(value: number, digits: number = 2): string {
    if (digits < 0 || digits > 20) {
      return ""
    }
    return util.format('%f', value.toFixed(digits))
  }
}