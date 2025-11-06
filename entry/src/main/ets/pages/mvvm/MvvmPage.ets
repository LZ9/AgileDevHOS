import { BaseContainer, BaseContainerVm, CoreConstants, DataError, PromiseAgent, PromptUtils } from '@lodz/pandora'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { TodoItemView } from '../../view/mvvm/TodoItemView'
import { ApiManager } from '../../api/ApiManager'

@Builder
export function MvvmPageBuilder() {
  MvvmPage()
}
/**
 * mvvm用例页面
 * Created by zhouL on 2025/7/23.
 */
@ComponentV2
export struct MvvmPage {
  /** 基类属性 */
  @Local public vm: BaseContainerVm = new BaseContainerVm()
  /** 代办列表 */
  @Local public todoList: Array<TodoBean> = []

  @Local public isAllFinish: boolean = false

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>()
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.onReloadClick = () => {
        this.vm.showStatusLoading()
        this.requestTodoList()
      }
      this.requestTodoList()
    }
  }

  /** 请求代办列表 */
  private requestTodoList() {
    PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiManager.create().getTodoList(this.getUIContext().getHostContext()))
      .subscribe({
        onSubscribe: () => {
          this.vm.showStatusLoading()
        },
        onNext: (t: ResponseBean<Array<TodoBean>>) => {
          this.todoList = t.data?? []
          this.vm.showStatusCompleted()
        },
        onError: (e: DataError<ResponseBean<Array<TodoBean>>>) => {
          PromptUtils.toastShort(this.getUIContext(), e.getTips())
          this.vm.showStatusError()
        }
      })
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentComponent()
        },
        titleBarExpandLayout: () => {
          this.expandComponent()
        }
      })
    }
  }

  @Builder
  expandComponent() {
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
  contentComponent() {
    // 列表
    List() {
      ForEach(this.todoList, (item: TodoBean) => {
        ListItem() {
          TodoItemView({ todoBean: item })
        }
      })
    }
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
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
