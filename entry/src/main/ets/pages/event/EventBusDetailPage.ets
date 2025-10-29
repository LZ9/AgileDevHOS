import { BaseContainer, BaseContainerVm, EventBus, PreferencesUtils,
  PromptUtils,
  SelectorModifier } from "@lodz/pandora"
import { TestEvent } from "../../bean/event/TestEvent"
import { Constants } from "../../config/Constants"

@Builder
export function EventBusDetailPageBuilder() {
  EventBusDetailPage()
}


/**
 * EventBus测试详情类
 * Created by zhouL on 2025/10/29.
 */
@ComponentV2
export struct EventBusDetailPage {
  /** 基类属性 */
  @Local vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = $r('app.string.event_bus_detail_title')
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.stack.pop()
      }
      this.vm.showStatusCompleted()
    }
  }

  /** 发送事件 */
  private sendEvent() {
    const value = PreferencesUtils.get().getSync(Constants.Preferences.GITHUB_KEY, "")
    const event = new TestEvent(`来自EventBusDetailPage的事件信息：${value}`)
    EventBus.get().post(Constants.EventId.NORMAL_EVENT, event)
    PromptUtils.toastShort(this.getUIContext(), "已发送")
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
    Row(){
      Button($r('app.string.event_bus_post'), { type: ButtonType.Normal, stateEffect: true })
        .layoutWeight(1)
        .height(40)
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .onClick(() => {
          this.sendEvent()
        })
    }
    .width('100%')
  }
}