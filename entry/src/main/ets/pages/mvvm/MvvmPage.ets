import { BaseContainer, BaseContainerVm, PromiseAgent, PromptUtils, RouterUtils } from '@lodz/pandora'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { ApiService } from '../../api/ApiService'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { TodoItemView } from '../../view/mvvm/TodoItemView'

/**
 * mvvm用例页面
 * Created by zhouL on 2025/7/23.
 */
@Entry
@ComponentV2
struct MvvmPage {
  /** 基类属性 */
  @Local public vm: BaseContainerVm = new BaseContainerVm()
  /** 代办列表 */
  @Local public todoList: Array<TodoBean> = []

  @Local public isAllFinish: boolean = false

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.mvvm_title')
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.vm.onReloadClick = () => {
      this.vm.showStatusLoading()
      this.requestTodoList()
     }
  }

  onDidBuild(): void {
    this.requestTodoList()
  }

  /** 请求代办列表 */
  private requestTodoList() {
    PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiService.create().getTodoList(this.getUIContext().getHostContext()))
      .subscribe({
        onSubscribe: () => {
          this.vm.showStatusLoading()
        },
        onNext: (t: ResponseBean<Array<TodoBean>>) => {
          this.todoList = t.data?? []
          this.vm.showStatusCompleted()
        },
        onError: (e: Error) => {
          PromptUtils.toastShort(this.getUIContext(), e.message)
          this.vm.showStatusError()
        }
      })
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
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
      .fontColor($r(`app.color.color_00A0E9`))
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
          TodoItemView({ todoBean: item })
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

}
