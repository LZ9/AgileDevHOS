import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  DateUtils,
  JsonUtils,
  RandomUtils,
  SelectorModifier
} from "@lodz/pandora"
import { LogListView } from "../../view/LogListView"
import { UserTypeObserved } from "./UserTypeObserved"

@Builder
export function ObservedV2DemoPageBuilder() {
  ObservedV2DemoPage()
}

/**
 * ObservedV2注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct ObservedV2DemoPage {
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
    Column() {
      ChildObservedV2()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildObservedV2 {
  @Local logList: Array<string> = []
  private onFieldChangedListener = (monitor: IMonitor) => {
    this.addLog("被修改的变量名称 : " + monitor.value()?.path)
    this.addLog("被修改的变量之前的值 : " + monitor.value()?.before)
    this.addLog("被修改的变量现在的值 : " + monitor.value()?.now)
  }
  // 类里面使用@ObservedV2和@Trace注解可以监听字段数据变化
  @Local aar: Array<UserTypeObserved> = [
    new UserTypeObserved(1, "张三", this.onFieldChangedListener),
    new UserTypeObserved(2, "李四")
  ]

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_8) + " ---> " + text)
  }

  build() {
    Column() {
      Text(`@Local aar: Array<UserTypeObserved> ； UserTypeObserved类里面使用@ObservedV2和@Trace注解可以监听字段数据变化`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`列表的json字符串：\n${JsonUtils.beanToJson(this.aar)}`)//UI会跟着变化
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .padding({ left: 10, right: 10 })
        .margin({ top: 20, bottom: 20 })

      Text(`遍历列表：`)
      ForEach(this.aar, (item: UserTypeObserved) => {
        Text(`id：${item.id} ； name：${item.name}`)
      })

      Button('修改数据', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 20 })
        .onClick(() => {
          this.aar[0].id = RandomUtils.getInt(100, 501)
          this.aar[1].name = `王五${RandomUtils.getInt(1, 10)}`
        })

      Text(`可以在@ObservedV2的类里面通过实现@Monitor()来监听某个字段的变化回调：`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)
        .margin({ top: 10 })

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
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}
