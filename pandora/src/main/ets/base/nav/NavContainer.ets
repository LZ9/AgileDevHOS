import { CoreConstants } from "@lodz/core_hos"
import { NavContainerVm } from "./NavContainerVm"

/**
 * Navigation容器
 * Created by zhouL on 2025/10/23.
 */
@ComponentV2
export struct NavContainer {
  @Param public vm: NavContainerVm = new NavContainerVm()
  /** 启动页名称 */
  @Param @Require pathName: string
  /** 启动参数 */
  @Param params ?: string | number | boolean | Record<string, object> = undefined
  /** 是否展示动画 */
  @Param animated?: boolean = undefined

  build() {
    Navigation(this.vm.stack) {
    }
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .hideNavBar(true)
    .onAppear(() => {
      this.vm.replacePathOpt(this.pathName, this.params, this.animated)
    })
  }
}