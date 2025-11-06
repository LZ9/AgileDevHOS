import { BaseContainer, BaseContainerVm, CoreConstants, JsonUtils, RandomUtils, SelectorModifier } from "@lodz/pandora"
import { UserType } from "../UserType"
import { UIUtils } from "@kit.ArkUI"

@Builder
export function MakeObservedDemoPageBuilder() {
  MakeObservedDemoPage()
}

/**
 * 可观察对象转换Demo类
 * Created by zhouL on 2025/11/6.
 */
@ComponentV2
export struct MakeObservedDemoPage {
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
      ChildMakeObserved()
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}

@ComponentV2
export struct ChildMakeObserved {
  @Local user?: UserType

  build() {
    Column() {
      Text(`通过UIUtils.makeObserved()方法，将普通对象转为可观测对象，不用再使用@ObservedV2和@Trace修饰`)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontColor($r('app.color.color_F0F0F0'))
        .backgroundColor(Color.Gray)
        .padding(10)

      Button('从服务端获取用户数据', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          const result = `{"code":123,"city":"Chengdu"}`
          this.user = UIUtils.makeObserved<UserType>(JsonUtils.jsonToBean(result)) //会自动把对象转为可观测，不用再使用@ObservedV2和@Trace
        })

      Text(`json : ${JsonUtils.beanToJson(this.user)}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10})

      Text(`user.code : ${this.user?.code}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10})

      Text(`user.city : ${this.user?.city}`)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10})

      Button('修改user.code', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          if (this.user !== undefined) {
            this.user.code++
          }
        })
    }
  }
}

