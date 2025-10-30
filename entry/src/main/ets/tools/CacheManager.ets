import { PreferencesUtils } from "@lodz/pandora"
import { Constants } from "../config/Constants"

/**
 * 缓存信息管理类
 * Created by zhouL on 2025/10/30.
 */
export class CacheManager {
  /** 获取用户缓存文字 */
  public static getUserText(def: string = "null"): string {
    return PreferencesUtils.get().getSync(Constants.Preferences.USER_KEY, def).valueOf() as string
  }

  /**
   * 设置用户缓存文字
   * @param text 文字内容
   */
  public static putUserText(text: string) {
    PreferencesUtils.get().putSync(Constants.Preferences.USER_KEY, text)
  }

  /** 获取Github缓存文字 */
  public static getGithubText(def: string = "null"): string {
    return PreferencesUtils.get().getSync(Constants.Preferences.GITHUB_KEY, def).valueOf() as string
  }

  /**
   * 设置Github缓存文字
   * @param text 文字内容
   */
  public static putGithubText(text: string) {
    PreferencesUtils.get().putSync(Constants.Preferences.GITHUB_KEY, text)
  }
}