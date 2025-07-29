import ThingsViewModel from "../../vm/mvvm/ThingsViewModel";
import { ThingsViewModelArray } from "../../vm/mvvm/TodoListViewModel";
import { ThingsComponent } from "./ThingsComponent";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
@Component
export struct TodoListComponent {
  @ObjectLink thingsViewModelArray: ThingsViewModelArray;

  build() {
    Column() {
      List() {
        ForEach(this.thingsViewModelArray, (item: ThingsViewModel) => {
          // 待办事项
          ListItem() {
            ThingsComponent({ things: item })
              .margin(5)
          }
        }, (item: ThingsViewModel) => {
          return item.thingsName;
        })
      }
    }
  }

}