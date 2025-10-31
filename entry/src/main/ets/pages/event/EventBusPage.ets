import { BaseContainer, BaseContainerVm,
  CoreConstants,
  DateUtils,
  EventBus,
  SelectorModifier } from "@lodz/pandora"
import { Constants } from "../../config/Constants"
import { RouterGuide } from "../../config/RouterGuide"
import { LogListView } from "../../view/LogListView"
import emitter from "@ohos.events.emitter"
import { TestEvent } from "../../bean/event/TestEvent"

@Builder
export function EventBusPageBuilder() {
  EventBusPage()
}

/**
 * EventBus测试类
 * Created by zhouL on 2025/10/29.
 */
@ComponentV2
export struct EventBusPage {
  /** 基类属性 */
  @Local vm: BaseContainerVm = new BaseContainerVm()
  /** 日志列表 */
  @Local private logList: Array<string> = []

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>("title")
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.showStatusCompleted()
    }
  }

  aboutToDisappear(): void {
    this.unregisterEvent()
  }

  /** 订阅事件 */
  private registerEvent(){
    EventBus.register(Constants.EventId.NORMAL_EVENT, (event: emitter.EventData) => {
      const data = event.data as TestEvent
      const date = data.date === undefined ? "" : `  ${DateUtils.getFormatString(CoreConstants.DateFormat.TYPE_17, data.date)}`
      this.addLog(data.content + date)
    })
  }

  /** 订阅单次事件 */
  private registerEventOnce(){
    EventBus.registerOnce(Constants.EventId.ONCE_EVENT, (event: emitter.EventData) => {
      const data = event.data as TestEvent
      const date = data.date === undefined ? "" : `  ${DateUtils.getFormatString(CoreConstants.DateFormat.TYPE_17, data.date)}`
      this.addLog(data.content + date)
    })
  }

  /** 取消订阅 */
  private unregisterEvent() {
    EventBus.unregister(Constants.EventId.NORMAL_EVENT)
    EventBus.unregister(Constants.EventId.ONCE_EVENT)
  }

  /** 发送事件 */
  private sendEvent() {
    EventBus.post(Constants.EventId.NORMAL_EVENT, new TestEvent("普通event", new Date()))
    EventBus.post(Constants.EventId.ONCE_EVENT, new TestEvent("单次event", new Date()))
  }

  /** 跳转详情页 */
  private goDetailPage() {
    this.vm.navVm.pushPath(RouterGuide.EventBusDetailPage)
  }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_8) + " ---> " + text)
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
      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))

      Row() {
        Button($r('app.string.event_bus_register'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ right: 5 })
          .onClick(() => {
            this.registerEvent()
          })

        Button($r('app.string.event_bus_register_once'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ left: 5 })
          .onClick(() => {
            this.registerEventOnce()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .padding({
        left: 10,
        right: 10,
        top: 5,
        bottom: 5
      })

      Row() {
        Button($r('app.string.event_bus_unregister'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ right: 5 })
          .onClick(() => {
            this.unregisterEvent()
          })

        Button($r('app.string.event_bus_post'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ left: 5 })
          .onClick(() => {
            this.sendEvent()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .padding({
        left: 10,
        right: 10,
        top: 5,
        bottom: 5
      })

      Row() {
        Button($r('app.string.event_bus_go_detail'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ right: 5 })
          .onClick(() => {
            this.goDetailPage()
          })

        Button($r('app.string.event_bus_clean_log'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .height(40)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .margin({ left: 5 })
          .onClick(() => {
            this.logList = []
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .padding({
        left: 10,
        right: 10,
        top: 5,
        bottom: 5
      })


    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}