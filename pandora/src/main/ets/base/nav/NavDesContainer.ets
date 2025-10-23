import { NavContainerVm } from "./NavContainerVm";

/**
 * NavDestination容器
 * Created by zhouL on 2025/10/23.
 */
@ComponentV2
export struct NavDesContainer {
  @Param public vm: NavContainerVm = new NavContainerVm()
  /** 内容布局 */
  @BuilderParam public contentLayout?: () => void

  build() {
    NavDestination() {
      this.contentLayout?.()
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.vm.stack = context.pathStack
      this.vm.pathInfo = context.pathInfo
    })
    .onAppear(() => {
      this.vm.onAppear?.()
    })
    .onBackPressed(() => {
      const block = this.vm.onBackPressed?.()
      return typeof block === 'boolean' ? block : false
    })
  }
}