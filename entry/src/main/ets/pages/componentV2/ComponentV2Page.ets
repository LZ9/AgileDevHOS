import { BaseContainer, BaseContainerVm, JsonUtils, PrintLog, RandomUtils } from '@lodz/pandora'
import { Constants } from '../../config/Constants'
import { UserType } from './UserType'
import { UserTypeObserved } from './UserTypeObserved'
import { UIUtils } from '@kit.ArkUI'
import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { RouterGuide } from '../../config/RouterGuide'

/**
 * ComponentV2装饰器用例
 * Created by zhouL on 2025/7/30.
 */
@ComponentV2
@HMRouter({ pageUrl: RouterGuide.ComponentV2Page })
export struct ComponentV2Page {
  @Local vm: BaseContainerVm = new BaseContainerVm()

  // 该变量要传递到子组件的子组件中（ChildConsumer）
  @Provider() count: number = 1

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      HMRouterMgr.pop()
    }
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.component_v2_title')
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
  }

  /** 更新计数器事件函数 */
  private updateCountEvent(i: number) {
    this.count = this.count + i
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


        ChildMakeObserved()
        ChildBind({num: this.count!!})//通过双感叹号实现自定义双向绑定
        ChildMonitor()
        ChildComputed()
        ChildProvider()
        ChildEvent({
          n: this.count,
          updateCountListener: (i: number) => {
            this.updateCountEvent(i)
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
export struct ChildMakeObserved {

  @Local user: UserType = new UserType(1, "张三")

  build() {
    Column() {
      Text(`------------- @MakeObserved --------------`)
      Button("从服务端获取用户数据").onClick(() => {
        const result = `{"code":123,"city":"Chengdu"}`
        this.user = UIUtils.makeObserved<UserType>(JsonUtils.jsonToBean(result))//会自动把对象转为可观测，不用再使用@ObservedV2和@Trace
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
export struct ChildBind {
  @Local msgSys: string = "系统控件双向绑定"
  @Param num: number = 500
  @Event $num: (value: number) => void = () => {}

  build() {
    Column() {
      Text(`------------- @Bind --------------`)
      //系统组件自带的双向同步
      Text(this.msgSys)
      TextInput({text: $$this.msgSys})

      //实现自定义子组件的数据双向绑定
      Text(this.num.toString())
      Button("修改num").onClick(() => {
        this.$num(this.num + 3)
      })
      Text(`------------- @Bind --------------`)
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
      Row(){
        Button("修改count").onClick(() => {
          this.count++
        })
        Button("修改foo").onClick(() => {
          this.foo = !this.foo
        })
      }
      Row(){
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

@ComponentV2
export struct ChildProvider {
  @Local msg: string = "我是ChildProvider组件"

  // 自定义传入子组件的名称（需要和子组件内变量的名称一致）
  @Provider(`index`) num: number = 1

  build() {
    Column() {
      Text(`------------- @Provider --------------`)
      Text(this.msg)
      ChildConsumer()
      Button(`修改`).onClick(() => {
        this.num++
      })
      Text(`------------- @Provider --------------`)
    }
    .margin(10)
    .width('100%')
    .height(400)
    .backgroundColor(Color.Pink)
  }
}

@ComponentV2
export struct ChildConsumer {
  @Local msg: string = "我是ChildConsumer组件"
  // 接收父组件的数据，并双向同步
  @Consumer() count: number = 100
  @Consumer() index: number = -1


  build() {
    Column() {
      Text(`---------- @Consumer -----------`)
      Text(this.msg)
      Text(`最外层传入的count的值 ->  ${this.count}`)
      Text(`ChildProvider传入的index的值 ->  ${this.index}`)
      Button(`修改`).onClick(() => {
        this.count--
        this.index--
      })
      Text(`---------- @Consumer -----------`)
    }
    .margin(10)
    .width(300)
    .height(200)
    .backgroundColor(Color.Green)
  }
}

@ComponentV2
export struct ChildEvent {
  @Param n: number = -1
  //定义一个函数来通知外部操作父组件的数据变化，从而使子组件的数据可以被更新
  @Event updateCountListener: (i: number) => void = () => {}

  // 随机数 1- 9
  @Local i : number = RandomUtils.getInt(1, 10)

  build() {
    Column() {
      Text(`------------- @Event --------------`)
      Text(`子组件n的值 : ${this.n}`)
      Button(`增加随机值 ${this.i}`).onClick(() => {
        this.updateCountListener(this.i)
      })
      Text(`------------- @Event --------------`)
    }
    .margin(10)
  }
}

@ComponentV2
export struct ChildOnce {
  // 该字段只能被外部赋值1次，并且允许内部修改该字段的值，且修改后的数据不会同步回父组件
  @Param @Once n: number = -1
  build() {
    Column() {
      Text(`------------- @Once --------------`)
      Text(`子组件n的值 : ${this.n}`)
      Button("修改").onClick(() => {
        this.n++
      })
      Text(`------------- @Once --------------`)
    }
    .margin(10)
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
    .margin(10)
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
        this.aar[0].id = RandomUtils.getInt(100, 501)
        this.aar[1].name = `王五${RandomUtils.getInt(1, 10)}`
      })
      Text(`------------- @ObservedV2 --------------`)
    }
    .margin(10)
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
    .margin(10)
  }
}