import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  SelectorModifier
} from '@lodz/pandora'
import { RouterGuide } from '../../config/RouterGuide'

@Builder
export function ComponentV2PageBuilder() {
  ComponentV2Page()
}

/**
 * ComponentV2装饰器用例
 * Created by zhouL on 2025/7/30.
 */
@ComponentV2
export struct ComponentV2Page {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  // 该变量要传递到子组件的子组件中（ChildConsumer）
  @Provider() count: number = 1

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

      // @Local注解使用
      Button($r('app.string.componentV2_local'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.LocalDemoPage, $r('app.string.componentV2_local'))
        })

      // @ObservedV2注解使用
      Button($r('app.string.componentV2_observedV2'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ObservedV2DemoPage, $r('app.string.componentV2_observedV2'))
        })

      // @Param搭配@Require注解使用
      Button($r('app.string.componentV2_param_require'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamRequireDemoPage, $r('app.string.componentV2_param_require'))
        })

      // @Param搭配@Once注解使
      Button($r('app.string.componentV2_param_once'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamOnceDemoPage, $r('app.string.componentV2_param_once'))
        })

      // @Param搭配@Event注解使用
      Button($r('app.string.componentV2_param_event'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamEventDemoPage, $r('app.string.componentV2_param_event'))
        })

      // 双向绑定使用
      Button($r('app.string.componentV2_double_bind'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.DoubleBindDemoPage, $r('app.string.componentV2_double_bind'))
        })

      // @Provider注解使用
      Button($r('app.string.componentV2_provider'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ProviderDemoPage, $r('app.string.componentV2_provider'))
        })

      // @Computed注解使用
      Button($r('app.string.componentV2_computed'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ComputedDemoPage, $r('app.string.componentV2_computed'))
        })

      // @Monitor注解使用
      Button($r('app.string.componentV2_monitor'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.MonitorDemoPage, $r('app.string.componentV2_monitor'))
        })

      // 可观察对象转换使用
      Button($r('app.string.componentV2_make_observed'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.MakeObservedDemoPage, $r('app.string.componentV2_make_observed'))
        })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .padding(10)
    .alignItems(HorizontalAlign.Start)
  }
}








