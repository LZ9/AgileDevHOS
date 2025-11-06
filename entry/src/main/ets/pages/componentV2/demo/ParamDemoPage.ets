import { BaseContainer, BaseContainerVm, CoreConstants, SelectorModifier } from "@lodz/pandora"

@Builder
export function ParamDemoPageBuilder() {
  ParamDemoPage()
}

/**
 * Param注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ParamDemoPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  // 该变量要传递到子组件的子组件中（ChildConsumer）
  @Local count: number = 1

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue <string>()
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
      Text(`@Local count: number ； 将count传入子组件`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Button('count增加', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.count++
        })

      Text(`父组件count的值 : ${this.count}`)
        .margin({ top: 10, bottom: 10 })

      ChildParam({ n: this.count })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildParam {
  // 只允许外部传入数据，内部不能进行修改
  @Param @Require n: number

  build() {
    Column() {
      Text(`@Param @Require n: number \n n只允许外部传入数据，内部不能进行修改，且数据会根据父组件的值变化而变化`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`子组件n的值 : ${this.n}`)
        .margin({ top: 10, bottom: 10 })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}