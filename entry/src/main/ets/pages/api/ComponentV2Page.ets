import { BaseContainer, BaseContainerVm, JsonUtils, RouterUtils } from '@lodz/pandora'

/**
 * 接口测试用例
 * Created by zhouL on 2025/7/30.
 */
@Entry
@ComponentV2
struct ComponentV2Page {
  @Local vm: BaseContainerVm = new BaseContainerVm()

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
    Column() {
      Child()
    }
  }
}

@ObservedV2
class UserType {
  @Trace id: number
  @Trace name: string

  constructor(id: number, name: string) {
    this.id = id;
    this.name = name;
  }
}

@ComponentV2
export struct Child {
  @Local aar: UserType[] = [
    new UserType(1, "张三"),
    new UserType(2, "李四")
  ]

  build() {
    Column() {
      Text(JsonUtils.beanToJson(this.aar))

      ForEach(this.aar, (item: UserType) => {
        Text(`${item.id} --- ${item.name}`)
      })

      Button("修改").onClick(() => {
        this.aar[0].id = 500 // UI观测不到变化
      })
    }
    .margin(20)
  }
}

