import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  DateUtils,
  JsonUtils,
  PromptUtils,
  RandomUtils,
  SelectorModifier
} from "@lodz/pandora"
import { LogListView } from "../../../view/LogListView"

@Builder
export function ComputedDemoPageBuilder() {
  ComputedDemoPage()
}

/**
 * Computed注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ComputedDemoPage {
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
    ChildComputed()
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildComputed {
  @Local logList: Array<string> = []
  @Local list: Array<number> = [1, 2, 3]

  // 支持将计算结果缓存，如果结算结果有变化再更新缓存
  @Computed
  private get getSum(): number {
    const sum = this.list.reduce((acc, cur) => acc + cur, 0)
    this.addLog(`触发计算，计算结果为：${sum}`)
    return sum
  }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_8) + " ---> " + text)
  }

  build() {
    Column() {
      Text(`使用@Computed修饰方法，被修饰的方法支持将计算结果缓存，如果结算结果有变化再更新缓存`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)


      Text(`数字列表：${JsonUtils.beanToJson(this.list)}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 20, bottom: 20 })

      Text(`本次购买的商品总价是 : ${this.getSum}`)
        .padding({ left: 10, right: 10 })
        .margin({ bottom: 20 })

      Row() {
        Button("往列表随机添加数据", { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 5 })
          .onClick(() => {
            this.list.push(RandomUtils.getInt(0, 5))
          })

        Button("获取商品总价", { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 5 })
          .onClick(() => {
            PromptUtils.toastShort(this.getUIContext(), `本次购买的商品总价是 : ${this.getSum}`)
          })
      }
      .margin({ bottom: 20 })

      LogListView({ logList: this.logList })
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .layoutWeight(1)
        .margin({ top: 10 })

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))
        .margin({ top: 10, bottom: 10 })

      Button('清空日志', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .onClick(() => {
          this.logList = []
        })
    }
  }
}

