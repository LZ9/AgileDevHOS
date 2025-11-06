import { BaseContainer, BaseContainerVm, CoreConstants, SelectorModifier } from "@lodz/pandora"

@Builder
export function DoubleBindDemoPageBuilder() {
  DoubleBindDemoPage()
}

/**
 * 双向绑定demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct DoubleBindDemoPage {
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
      Text(`@Local count: number \n将count传入子组件，使用双感叹号（num: this.count!!）实现自定义双向绑定`)
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

      ChildBind({ num: this.count!! }) //通过双感叹号实现自定义双向绑定
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)

  }
}

@ComponentV2
export struct ChildBind {
  @Local msg: string = "使用双美元符号$$实现系统控件双向绑定"
  @Param num: number = -1
  @Event $num: (value: number) => void = () => {}

  build() {
    Column() {
      Text(`@Param num: number = -1 \n @Event $num: (value: number) => void = () => {} \n通过@Param和@Event互相搭配，保持字段名一致（@Event注解的字段前要加$），实现自定义子组件的数据双向绑定`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      //实现自定义子组件的数据双向绑定
      Text(this.num.toString())
        .margin({ top: 10, bottom: 10 })

      Button(`修改子组件内num的值+3`, { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.$num(this.num + 3)
        })

      Text(`使用系统组件例如TextInput实现双向绑定时，使用双美元符号（text: $$this.msg）实现双向绑定`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      //系统组件自带的双向同步
      Text(`输入框内容：${this.msg}`)
        .margin({ top: 10, bottom: 10 })

      TextInput({ text: $$this.msg })
        .margin({ left: 10, right: 10 })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}