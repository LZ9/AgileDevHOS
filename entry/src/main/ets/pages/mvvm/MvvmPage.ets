import TodoListViewModel from '../../vm/mvvm/TodoListViewModel';
import { common } from '@kit.AbilityKit';
import { TodoComponent } from '../../view/mvvm/TodoComponent';
import { AllChooseComponent } from '../../view/mvvm/AllChooseComponent';
import { TodoListComponent } from '../../view/mvvm/TodoListComponent';

/**
 * mvvm用例页面
 * Created by zhouL on 2025/7/23.
 */
@Entry
@Component
struct MvvmPage {
  //https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-mvvm

  @State thingsTodo: TodoListViewModel = new TodoListViewModel(); // View绑定ViewModel的数据
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  async aboutToAppear() {
    await this.thingsTodo.loadTasks(this.context);
  }

  build() {
    Column() {
      Row({ space: 40 }) {
        // 全部待办
        TodoComponent()
        // 全选
        AllChooseComponent({ thingsViewModel: this.thingsTodo })
      }

      Column() {
        TodoListComponent({ thingsViewModelArray: this.thingsTodo.things })
      }
    }
    .height('100%')
    .width('100%')
    .margin({ top: 5, bottom: 5 })
    .backgroundColor('#90f1f3f5')
  }
}
