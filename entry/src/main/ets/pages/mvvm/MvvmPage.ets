import { BaseContainer, BaseContainerAttribute, PromiseAgent, RouterUtils } from '@lodz/pandora'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { ApiService } from '../../api/ApiService'
import { ResponseBean } from '../../bean/base/ResponseBean'

/**
 * mvvm用例页面
 * Created by zhouL on 2025/7/23.
 */
@Entry
@Component
struct MvvmPage {
  /** 基类属性 */
  @State public attribute: BaseContainerAttribute = new BaseContainerAttribute()
  /** 代办列表 */
  @State public todoList: Array<TodoBean> = []

  @State public isAllFinish: boolean = false

  aboutToAppear(): void {
    this.attribute.setScopeConfig()
    this.attribute.titleBarViewAttribute.titleOptions.title = $r('app.string.mvvm_title')
    this.attribute.titleBarViewAttribute.backImgOptions.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
  }

  onDidBuild(): void {
    PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiService.create().getTodoList(this.getUIContext().getHostContext()))
      .run({
        onSubscribe: () => {
          this.attribute.showStatusLoading()
        },
        onNext: (t: ResponseBean<Array<TodoBean>>) => {
          this.todoList = t.data?? []
          this.attribute.showStatusCompleted()
        },
        onError: (e: Error) => {
          this.attribute.showStatusError()
        }
      })
  }

  build() {
    Stack() {
      BaseContainer({
        attribute: this.attribute,
        contentLayout: () => {
          this.contentLayout()
        },
        titleBarExpandLayout: () => {
          this.expandLayout()
        }
      })
    }
  }

  @Builder
  expandLayout() {
    Button(this.isAllFinish ? "取消全选" : "全选", { type: ButtonType.Capsule })
      .width(80)
      .height(30)
      .fontSize(12)
      .margin({ right: 10 })
      .fontColor($r(`app.color.color_00a0e9`))
      .backgroundColor(Color.White)
      .onClick(() => {
        this.setTodoListFinish(!this.isAllFinish)
        this.isAllFinish = !this.isAllFinish
      })
  }

  @Builder
  contentLayout() {
    // 列表
    List() {
      ForEach(this.todoList, (item: TodoBean) => {
        ListItem() {
          Text(item.title)
            .width('100%')
            .fontSize(20)
            .textAlign(TextAlign.Start)
            .padding(10)
            .onClick(() => {

            })
        }
      })
    }
    .height('100%')
    .width('100%')
    .alignListItem(ListItemAlign.Center)
  }

  /**
   * 设置待办列表是否完成
   * @param isAllFinish 是否全部完成
   */
  private setTodoListFinish(isAllFinish: boolean) {
    for (let i = 0; i < this.todoList.length; i++) {
      this.todoList[i].isFinish = isAllFinish;
    }
  }


  //https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-mvvm

  // @State thingsTodo: TodoListViewModel = new TodoListViewModel() // View绑定ViewModel的数据
  // private context = this.getUIContext().getHostContext() as common.UIAbilityContext
  //
  // async aboutToAppear() {
  //   await this.thingsTodo.loadTasks(this.context)
  // }

  // build() {
  //   Column() {
  //     Row({ space: 40 }) {
  //       // 全部待办
  //       TodoComponent()
  //       // 全选
  //       AllChooseComponent({ thingsViewModel: this.thingsTodo })
  //     }
  //
  //     Column() {
  //       TodoListComponent({ thingsViewModelArray: this.thingsTodo.things })
  //     }
  //   }
  //   .height('100%')
  //   .width('100%')
  //   .margin({ top: 5, bottom: 5 })
  //   .backgroundColor('#90f1f3f5')
  // }
}
