import { display } from "@kit.ArkUI";

/**
 * 设备工具类
 * Created by zhouL on 2025/7/22.
 */
export class DeviceUtils {

  /** 获取屏幕高度 */
  public static getScreenHeight(): number {
    return display.getDefaultDisplaySync().height
  }

  /** 获取屏幕宽度 */
  public static getScreenWidth(): number {
    return display.getDefaultDisplaySync().width
  }

  /** 获取屏幕可用高度 */
  public static getScreenAvailableHeight(): number {
    return display.getDefaultDisplaySync().availableHeight
  }

  /** 获取屏幕可用宽度 */
  public static getScreenAvailableWidth(): number {
    return display.getDefaultDisplaySync().availableWidth
  }
}
