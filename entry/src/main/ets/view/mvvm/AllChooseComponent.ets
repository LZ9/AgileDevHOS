import TodoListViewModel from "../../vm/mvvm/TodoListViewModel";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
@Component
export struct AllChooseComponent {
  @State titleName: string = '全选';
  @Link thingsViewModel: TodoListViewModel;

  build() {
    Row() {
      Button(`${this.titleName}`, { type: ButtonType.Capsule })
        .onClick(() => {
          this.thingsViewModel.chooseAll(); // View层点击事件发生时，调用ViewModel层方法chooseAll处理逻辑
          this.titleName = this.thingsViewModel.isChoosen ? '全选' : '取消全选';
        })
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#f7f6cc74')
    }
    .padding({ left: this.thingsViewModel.isChoosen ? 15 : 0 })
    .width('100%')
    .margin({ top: 10, bottom: 10 })
  }
}