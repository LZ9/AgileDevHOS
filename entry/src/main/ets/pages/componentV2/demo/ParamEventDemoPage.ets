import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  RandomUtils,
  SelectorModifier
} from "@lodz/pandora"

@Builder
export function ParamEventDemoPageBuilder() {
  ParamEventDemoPage()
}

/**
 * Param搭配Event注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ParamEventDemoPage {
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

  /** 更新计数器事件函数 */
  private updateCountEvent(i: number) {
    this.count = this.count + i
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

      ChildEvent({
        n: this.count,
        updateCountListener: (i: number) => {
          this.updateCountEvent(i)
        }
      })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildEvent {
  @Param n: number = -1
  //定义一个回调函数来通知父组件当前子组件内的数据变化情况
  @Event updateCountListener?: (i: number) => void
  // 随机数 1- 9
  private i: number = RandomUtils.getInt(2, 10)

  build() {
    Column() {
      Text(`@Event updateCountListener?: (i: number) => void \n定义一个回调函数来通知父组件当前子组件内的数据变化情况`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`子组件n的值 : ${this.n}`)
        .margin({ top: 10, bottom: 10 })

      Button(`将子组件生成的随机值 ${this.i} 返回给父组件`, { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.updateCountListener?.(this.i)
        })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}
