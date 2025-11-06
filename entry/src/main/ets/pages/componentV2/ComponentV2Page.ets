import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  JsonUtils,
  PrintLog,
  RandomUtils,
  SelectorModifier
} from '@lodz/pandora'
import { Constants } from '../../config/Constants'
import { UserType } from './UserType'
import { UserTypeObserved } from './UserTypeObserved'
import { UIUtils } from '@kit.ArkUI'
import { RouterGuide } from '../../config/RouterGuide'

@Builder
export function ComponentV2PageBuilder() {
  ComponentV2Page()
}

/**
 * ComponentV2装饰器用例
 * Created by zhouL on 2025/7/30.
 */
@ComponentV2
export struct ComponentV2Page {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  // 该变量要传递到子组件的子组件中（ChildConsumer）
  @Provider() count: number = 1

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

      // @Local注解使用
      Button($r('app.string.componentV2_local'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.LocalDemoPage, $r('app.string.componentV2_local'))
        })

      // @ObservedV2注解使用
      Button($r('app.string.componentV2_observedV2'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ObservedV2DemoPage, $r('app.string.componentV2_observedV2'))
        })

      // @Param搭配@Require注解使用
      Button($r('app.string.componentV2_param_require'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamRequireDemoPage, $r('app.string.componentV2_param_require'))
        })

      // @Param搭配@Once注解使
      Button($r('app.string.componentV2_param_once'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamOnceDemoPage, $r('app.string.componentV2_param_once'))
        })

      // @Param搭配@Event注解使用
      Button($r('app.string.componentV2_param_event'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ParamEventDemoPage, $r('app.string.componentV2_param_event'))
        })

      // 双向绑定使用
      Button($r('app.string.componentV2_double_bind'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.DoubleBindDemoPage, $r('app.string.componentV2_double_bind'))
        })

      // @Provider注解使用
      Button($r('app.string.componentV2_provider'), { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .fontColor(Color.White)
        .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
        .fontSize(14)
        .margin({ top: 10 })
        .onClick(() => {
          this.vm.navVm.pushPathOpt(RouterGuide.ProviderDemoPage, $r('app.string.componentV2_provider'))
        })

    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .padding(10)
    .alignItems(HorizontalAlign.Start)


    Scroll() {
      Column() {
        Row() {
          Button("count增加")
            .margin({ left: 10, right: 10 })
            .onClick(() => {
              this.count++
            })

          Text(`父组件count的值 : ${this.count}`)
            .margin({ left: 10, right: 10 })
        }
        .width(CoreConstants.LayoutParams.MATCH_PARENT)


        ChildMakeObserved()

        ChildMonitor()
        ChildComputed()

      }
    }
    .visibility(Visibility.None)
  }
}


@ComponentV2
export struct ChildMakeObserved {
  @Local user: UserType = new UserType(1, "张三")

  build() {
    Column() {
      Text(`------------- @MakeObserved --------------`)
      Button("从服务端获取用户数据").onClick(() => {
        const result = `{"code":123,"city":"Chengdu"}`
        this.user = UIUtils.makeObserved<UserType>(JsonUtils.jsonToBean(result)) //会自动把对象转为可观测，不用再使用@ObservedV2和@Trace
      })
      Text(`json : ${JsonUtils.beanToJson(this.user)}`)
      Text(`user.code : ${this.user.code}`)
      Text(`user.city : ${this.user.city}`)
      Button("修改").onClick(() => {
        this.user.code++
      })
      Text(`------------- @MakeObserved --------------`)
    }
    .margin(10)
  }
}



@ComponentV2
export struct ChildMonitor {
  @Local count: number = 0
  @Local foo: boolean = true
  @Local user: UserTypeObserved = new UserTypeObserved(1, '张三')

  //支持监听变量值的变化
  @Monitor(`count`,`foo`,`user.id`,`user.name`)
  handle(monitor: IMonitor) {
    //被修改的变量名称
    PrintLog.d(Constants.Log.TAG, "被修改的变量名称 : " + monitor.value()?.path)
    PrintLog.d(Constants.Log.TAG, "被修改的变量之前的值 : " + monitor.value()?.before)
    PrintLog.d(Constants.Log.TAG, "被修改的变量现在的值 : " + monitor.value()?.now)
  }

  build() {
    Column() {
      Text(`------------- @Computed --------------`)
      Text(`count : ${this.count}`)
      Text(`foo : ${this.foo}`)
      Text(`user : ${this.user.id} , ${this.user.name}`)
      Row() {
        Button("修改count").onClick(() => {
          this.count++
        })
        Button("修改foo").onClick(() => {
          this.foo = !this.foo
        })
      }

      Row() {
        Button("修改user.id").onClick(() => {
          this.user.id++
        })
        Button("修改user.name").onClick(() => {
          this.user.name = `李四${RandomUtils.getInt(1, 10)}`
        })
      }

      Text(`------------- @Computed --------------`)
    }
    .margin(10)
  }
}

@ComponentV2
export struct ChildComputed {
  @Local list: Array<number> = [100, 200, 300]

  // 支持将计算结果缓存，如果结算结果有变化再更新缓存
  @Computed
  private get getSum(): number {
    return this.list.reduce((acc, cur) => acc + cur, 0)
  }

  build() {
    Column() {
      Text(`------------- @Computed --------------`)
      Text(JsonUtils.beanToJson(this.list))
      Text(`本次购买的商品总价是 : ${this.getSum}`)
      Button("添加列表数据").onClick(() => {
        this.list.push(500)
      })
      Text(`------------- @Computed --------------`)
    }
    .margin(10)
  }
}







