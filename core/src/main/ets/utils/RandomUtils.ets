import { util } from "@kit.ArkTS"

/**
 * 随机数工具类
 * Created by zhouL on 2025/8/5.
 */
export class RandomUtils {
  /**
   * 获取随机整数
   * @param min 最小值（包含）
   * @param max 最大值（不包含）
   */
  public static getInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min) + min)
  }

  /**
   * 获取随机UUID（32位）
   * @param entropyCache 是否使用缓存（默认true）
   */
  public static getUUID(entropyCache: boolean = false): string {
    return util.generateRandomUUID(entropyCache).replace(/-/g, '')
  }

}