import { BaseContainer, BaseContainerVm, CoreConstants, SelectorModifier } from "@lodz/pandora"

@Builder
export function ParamOnceDemoPageBuilder() {
  ParamOnceDemoPage()
}

/**
 * Param搭配Once注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ParamOnceDemoPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  // 该变量要传递到子组件的子组件中
  @Local count: number = 1

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
    Column() {
      Text(`@Local count: number ； 将count传入子组件`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`父组件count的值 : ${this.count}`)
        .margin({ top: 10, bottom: 10 })

      Button('count增加', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.count++
        })

      ChildOnce({ n: this.count })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildOnce {
  // 该字段只能被外部赋值1次，并且允许内部修改该字段的值，且修改后的数据不会同步回父组件
  @Param @Once n: number = -1

  build() {
    Column() {
      Text(`@Param @Once n: number = -1 \n字段n只能被外部赋值1次,父组件的数据变化不再影响到子组件内部。\n并且允许子组件内部修改字段n的值，且修改后的数据不会同步回父组件`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`子组件n的值 : ${this.n}`)
        .margin({ top: 10, bottom: 10 })

      Button('子组件内修改', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .onClick(() => {
          this.n++
        })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}