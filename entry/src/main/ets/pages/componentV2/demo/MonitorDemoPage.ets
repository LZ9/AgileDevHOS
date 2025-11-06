import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  DateUtils,
  RandomUtils,
  SelectorModifier
} from "@lodz/pandora"
import { LogListView } from "../../../view/LogListView"
import { UserTypeObserved } from "../UserTypeObserved"

@Builder
export function MonitorDemoPageBuilder() {
  MonitorDemoPage()
}

/**
 * Monitor注解Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct MonitorDemoPage {
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
      ChildMonitor()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildMonitor {
  @Local logList: Array<string> = []
  @Local count: number = 0
  @Local foo: boolean = true
  @Local user: UserTypeObserved = new UserTypeObserved(1, '张三')

  //支持监听变量值的变化
  @Monitor(`count`,`foo`,`user.id`,`user.name`)
  handle(monitor: IMonitor) {
    //被修改的变量名称
    this.addLog("被修改的变量名称 : " + monitor.value()?.path)
    this.addLog("被修改的变量之前的值 : " + monitor.value()?.before)
    this.addLog("被修改的变量现在的值 : " + monitor.value()?.now)
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
      Text(`通过@Monitor(\`xxx\`)注解方法，在方法内可以监听对应字段的数据变化`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`count : ${this.count}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10 })

      Text(`foo : ${this.foo}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10 })

      Text(`user -> id : ${this.user.id} , name : ${this.user.name}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10, bottom: 10 })

      Row() {
        Button('修改count', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 5 })
          .onClick(() => {
            this.count++
          })

        Button('修改foo', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 5 })
          .onClick(() => {
            this.foo = !this.foo
          })
      }
      .margin({ bottom: 10 })

      Row() {
        Button('修改user.id', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 5 })
          .onClick(() => {
            this.user.id++
          })

        Button('修改user.name', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 5 })
          .onClick(() => {
            this.user.name = `李四${RandomUtils.getInt(1, 10)}`
          })
      }
      .margin({ bottom: 10 })

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))
        .margin({ bottom: 10 })

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