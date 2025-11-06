import { BaseContainer, BaseContainerVm } from "@lodz/pandora"

@Builder
export function SandwichContainerPageBuilder() {
  SandwichContainerPage()
}

/**
 * 基础状态控件、中部刷新控件和顶部/底部扩展容器Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct SandwichContainerPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<Resource>()
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.showStatusCompleted()
    }
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentComponent()
        }
      })
    }
  }

  @Builder
  contentComponent() {

  }
}