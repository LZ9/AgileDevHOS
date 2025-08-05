import { BaseContainer, BaseContainerVm, JsonUtils, RouterUtils } from '@lodz/pandora'
import { UserType } from './UserType'
import { UserTypeObserved } from './UserTypeObserved'

/**
 * 接口测试用例
 * Created by zhouL on 2025/7/30.
 */
@Entry
@ComponentV2
struct ComponentV2Page {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  @Local count: number = 1

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.component_v2_title')
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
  }

  /** 更新计数器事件函数 */
  private updateCountEvent() {
    this.count = this.count + 5
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentLayout()
        }
      })
    }
  }

  @Builder
  contentLayout() {
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
        .width('100%')

        ChildEvent({
          n: this.count,
          updateCountListener: () => {
            this.updateCountEvent()
          }
        })
        ChildOnce({ n: this.count })
        ChildParam({ n: this.count })
        ChildObserved()
        ChildLocal()
      }
    }
  }
}








@ComponentV2
export struct ChildEvent {
  @Param n: number = -1
  //定义一个函数来通知外部操作父组件的数据变化，从而使子组件的数据可以被更新
  @Event
  updateCountListener: () => void = () => {}

  build() {
    Column() {
      Text(`------------- @Event --------------`)
      Text(`子组件n的值 : ${this.n}`)
      Button("修改").onClick(() => {
        this.updateCountListener()
      })
      Text(`------------- @Event --------------`)
    }
    .margin(20)
  }
}

@ComponentV2
export struct ChildOnce {
  // 该字段只能被外部赋值1次，并且允许内部修改该字段的值，且修改后的数据不会同步回父组件
  @Param
  @Once
  n: number = -1
  build() {
    Column() {
      Text(`------------- @Once --------------`)
      Text(`子组件n的值 : ${this.n}`)
      Button("修改").onClick(() => {
        this.n++
      })
      Text(`------------- @Once --------------`)
    }
    .margin(20)
  }
}

@ComponentV2
export struct ChildParam {
  // 只允许外部传入数据，内部不能进行修改
  @Param n: number = -1
  build() {
    Column() {
      Text(`------------- @Param --------------`)
      Text(`子组件n的值 : ${this.n}`)
      Text(`------------- @Param --------------`)
    }
    .margin(20)
  }
}

@ComponentV2
export struct ChildObserved {
  // 类里面使用@ObservedV2和@Trace注解可以监听字段数据变化
  @Local aar: Array<UserTypeObserved> = [
    new UserTypeObserved(1, "张三"),
    new UserTypeObserved(2, "李四")
  ]

  build() {
    Column() {
      Text(`------------- @ObservedV2 --------------`)
      Text(`json : ${JsonUtils.beanToJson(this.aar)}`)
      ForEach(this.aar, (item: UserTypeObserved) => {
        Text(`${item.id} --- ${item.name}`)
      })

      Button("修改").onClick(() => {
        this.aar[0].id = 500
        this.aar[1].name = `王五`
      })
      Text(`------------- @ObservedV2 --------------`)
    }
    .margin(20)
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
      Text(`-------------- @Local ---------------`)
      Text(`json : ${JsonUtils.beanToJson(this.aar)}`)//UI会跟着变化

      ForEach(this.aar, (item: UserType) => {
        Text(`${item.code} --- ${item.city}`)
      })
      Button("修改").onClick(() => {
        this.aar[0].code = -1
        this.aar[1] = new UserType(5, "Nanjing")
      })
      Text(`-------------- @Local ---------------`)
    }
    .margin(20)
  }
}