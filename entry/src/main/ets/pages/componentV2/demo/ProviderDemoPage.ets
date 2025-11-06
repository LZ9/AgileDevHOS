import { BaseContainer, BaseContainerVm, CoreConstants, SelectorModifier } from "@lodz/pandora"

@Builder
export function ProviderDemoPageBuilder() {
  ProviderDemoPage()
}

/**
 * Provider注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ProviderDemoPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  // 该变量要传递到子组件的子组件中（ChildConsumer）
  @Provider() count: number = 1

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
      Text(`@Provider() count: number \n将需要给子组件更新的字段count使用@Provider()注解修饰，无须传入子组件也能自动同步数据`)
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

      ChildProvider()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildProvider {
  // 将变量num和`index`名称绑定，实现数据自动同步
  @Provider(`index`) num: number = 1

  build() {
    Column() {
      Text(`@Provider(\`index\`) num : number \n这是ChildProvider组件，将变量num和\`index\`名称绑定，实现数据自动同步`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`num（绑定\`index\`）的值 : ${this.num}`)
        .margin({ top: 10, bottom: 10 })

      Button('修改num值+2', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.num += 2
        })

      ChildConsumer()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .backgroundColor(Color.Pink)
    .padding({ bottom: 10 })
  }
}

@ComponentV2
export struct ChildConsumer {
  // 接收父组件的数据，并双向同步
  @Consumer() count: number = 100
  @Consumer() index: number = -1

  build() {
    Column() {
      Text(`@Consumer() count: number \n@Consumer() index: number \n这是ChildConsumer组件，将变量count和index使用注解@Consumer()修饰，实现数据自动更新给父组件里绑定相同名称的变量`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`最外层绑定的count的值 ->  ${this.count}`)
        .margin({ top: 10, bottom: 10 })

      Text(`ChildProvider绑定的index的值 ->  ${this.index}`)
        .margin({ top: 10, bottom: 10 })

      Button('同时修改count和index的值', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.count--
          this.index--
        })
    }
    .width(340)
    .backgroundColor(Color.Yellow)
  }
}