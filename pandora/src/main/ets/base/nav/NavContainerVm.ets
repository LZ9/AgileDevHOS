/**
 * Navigation容器ViewModel
 * Created by zhouL on 2025/10/23.
 */
@ObservedV2
export class NavContainerVm {
  /** 导航路径 */
  @Trace public stack?: NavPathStack = new NavPathStack()
  /** 导航路径信息 */
  @Trace public pathInfo?: NavPathInfo
  /** 导航页面模式 */
  @Trace public mode: NavDestinationMode = NavDestinationMode.STANDARD
  /** 系统返回按钮拦截 */
  @Trace public onBackPressed?: () => boolean
  /** 系统返回按钮拦截 */
  @Trace public onAppear?: () => void

  /**
   * 返回上一页
   * @param animated 是否展示过度动画（默认true）
   */
  public back(animated?: boolean): NavPathInfo | undefined {
    return this.stack?.pop(animated ?? true)
  }

  /**
   * 返回上一页
   * @param result 返回结果
   * @param animated 是否展示过度动画（默认true）
   * @returns
   */
  public backOpt(result: Object, animated?: boolean): NavPathInfo | undefined {
    return this.stack?.pop(result, animated ?? true)
  }

  /**
   * 替换页面
   * @param pathName 页面名称
   * @param animated 是否展示过度动画（默认true）
   */
  public replacePath(pathName: string, animated?: boolean) {
    this.replacePathOpt(pathName, undefined, animated)
  }

  /**
   * 替换页面
   * @param pathName 页面名称
   * @param param 传递参数
   * @param animated 是否展示过度动画（默认true）
   */
  public replacePathOpt(pathName: string, param?: Object, animated?: boolean) {
    this.stack?.replacePathByName(pathName, param, animated ?? true)
  }

  /**
   * 添加页面
   * @param pathName 页面名称
   * @param onPop 页面返回参数回调
   * @param animated 是否展示过度动画（默认true）
   */
  public pushPath(pathName: string, onPop?: (popInfo: PopInfo) => void, animated?: boolean) {
    this.pushPathOpt(pathName, undefined, onPop, animated)
  }

  /**
   * 添加页面
   * @param pathName 页面名称
   * @param param 传递参数
   * @param onPop 页面返回参数回调
   * @param animated 是否展示过度动画（默认true）
   */
  public pushPathOpt(pathName: string, param?: Object, onPop?: (popInfo: PopInfo) => void, animated?: boolean) {
    this.stack?.pushPathByName(pathName, param, onPop, animated ?? true)
  }

  /**
   * 获取参数值
   * @param key 键名称（默认值是‘data’）
   */
  public getParamsValue<T>(): T | undefined {
    if (this.pathInfo === undefined) {
      return undefined
    }
    if (this.pathInfo.param === undefined || this.pathInfo.param === null) {
      return undefined
    }
    return this.pathInfo.param as T
  }
}