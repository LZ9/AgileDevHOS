/**
 * 路由导航
 * Created by zhouL on 2025/10/11.
 */
export class RouterGuide {
  /** 启动页 */
  public static readonly SplashPage = 'SplashPage'
  /** 主页 */
  public static readonly MainPage = 'MainPage'
  /** ComponentV2装饰器用例 */
  public static readonly ComponentV2Page = 'ComponentV2Page'
  /** Json转换测试 */
  public static readonly JsonPage = 'JsonPage'
  /** mvvm用例页面 */
  public static readonly MvvmPage = 'MvvmPage'
  /** Preferences测试类 */
  public static readonly PreferencesPage = 'PreferencesPage'
  /** Promise测试类 */
  public static readonly PromisePage = 'PromisePage'
  /** 刷新/加载更多测试类 */
  public static readonly RefreshLoadPage = 'RefreshLoadPage'

  /**
   * 获取参数值
   * @param key 键名称
   * @param pathInfo 路由信息对象
   */
  public static getParamsValue<T>(key: string, pathInfo?: NavPathInfo): T | undefined {
    if (pathInfo === undefined) {
      return undefined
    }
    if (pathInfo.param === undefined || pathInfo.param === null) {
      return undefined
    }
    const params = pathInfo.param as Record<string, object>
    const value: object | undefined | null = params[key]
    if (value === undefined || value === null) {
      return undefined
    }
    return value as T
  }
}