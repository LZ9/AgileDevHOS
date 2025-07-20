import { PandoraConstants } from "../config/PandoraConstants"
import { window } from "@kit.ArkUI"

/**
 * 状态栏工具类
 * Created by zhouL on 2025/7/20.
 */
export class StatusBarUtils {
  /** 单例对象 */
  private static instance: StatusBarUtils | null = null

  private constructor() {
  }

  /** 获取单例 */
  public static getInstance(): StatusBarUtils {
    if (!StatusBarUtils.instance) {
      StatusBarUtils.instance = new StatusBarUtils()
    }
    return StatusBarUtils.instance
  }

  /**
   * 保存当前窗口
   * @param context 上下文
   */
  public saveLastWindow(context: Context) {
    window.getLastWindow(context, (err, data) => {
      AppStorage.setOrCreate(PandoraConstants.Prop.WINDOW_CLASS, data)
    })
  }

  /**
   * 设置状态栏颜色
   * @param bgColor 背景颜色
   * @param contentColor 文字颜色
   */
  public setColor(bgColor: string, contentColor: string) {
    const win = AppStorage.get<window.Window>(PandoraConstants.Prop.WINDOW_CLASS)
    if (win === undefined) {
      return
    }
    win.setWindowSystemBarProperties({
      statusBarColor: bgColor,
      statusBarContentColor: contentColor,
    })
  }
}
