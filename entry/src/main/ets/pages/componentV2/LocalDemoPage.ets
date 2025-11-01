import { BaseContainer, BaseContainerVm, CoreConstants, JsonUtils, RandomUtils, SelectorModifier } from "@lodz/pandora"
import { UserType } from "./UserType"

@Builder
export function LocalDemoPageBuilder() {
  LocalDemoPage()
}

/**
 * Local注解Demo类
 * Created by zhouL on 2025/11/1.
 */
@ComponentV2
export struct LocalDemoPage {
  @Local vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>()
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
      ChildLocal()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildLocal {
  // 不允许外部传入参数
  @Local aar: Array<UserType> = [
    new UserType(0, "Beijing"),
    new UserType(1, "Shanghai")
  ]

  build() {
    Column() {
      Text(`@Local aar: Array<UserType>`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Text(`列表的json字符串：${JsonUtils.beanToJson(this.aar)}`)//UI会跟着变化
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .padding({ left: 10, right: 10 })
        .margin({ top: 20, bottom: 20 })

      Text(`遍历列表：`)
      ForEach(this.aar, (item: UserType) => {
        Text(`code：${item.code} ； city：${item.city}`)
      })

      Button('修改数据', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 20 })
        .onClick(() => {
          this.aar[0].code = RandomUtils.getInt(10, 20)
          this.aar[1] = new UserType(RandomUtils.getInt(20, 30), "Nanjing")
        })

      Text(`修改数据UI会跟着变化`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)
        .margin({ top: 30 })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}