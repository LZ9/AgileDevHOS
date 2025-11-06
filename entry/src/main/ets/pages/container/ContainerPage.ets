import { BaseContainer, BaseContainerVm, CoreConstants, SelectorModifier } from "@lodz/pandora"
import { RouterGuide } from "../../config/RouterGuide"

@Builder
export function ContainerPageBuilder() {
  ContainerPage()
}

/**
 * 基类容器测试类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ContainerPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>()
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
    Column() {
      // 带基础状态控件容器
      Button($r('app.string.container_page_base'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.BaseContainerPage, $r('app.string.container_page_base'))
        })

      // 带基础状态控件和下拉刷新控件容器
      Button($r('app.string.container_page_refresh'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.RefreshContainerPage, $r('app.string.container_page_refresh'))
        })

      // 带基础状态控件、中部刷新控件和顶部/底部扩展容器
      Button($r('app.string.container_page_sandwich'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.SandwichContainerPage, $r('app.string.container_page_sandwich'))
        })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .alignItems(HorizontalAlign.Start)
    .padding(10)
  }
}