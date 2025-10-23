/**
 * Navigation容器ViewModel
 * Created by zhouL on 2025/10/23.
 */
@ObservedV2
export class NavContainerVm {
  /** 导航路径 */
  @Trace public stack: NavPathStack = new NavPathStack()
  /** 导航路径信息 */
  @Trace public pathInfo?: NavPathInfo
  /** 导航页面模式 */
  @Trace public mode: NavDestinationMode = NavDestinationMode.STANDARD
  /** 系统返回按钮拦截 */
  @Trace public onBackPressed?: () => boolean
  /** 系统返回按钮拦截 */
  @Trace public onAppear?: () => void
}