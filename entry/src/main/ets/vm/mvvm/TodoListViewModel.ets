import ThingsViewModel from "./ThingsViewModel";
import { common } from "@kit.AbilityKit";
import TodoListModel from "../../bean/mvvm/TodoListModel";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
@Observed
export class ThingsViewModelArray extends Array<ThingsViewModel> {
}

@Observed
export default class TodoListViewModel {
  @Track isChoosen: boolean = true;
  @Track things: ThingsViewModelArray = new ThingsViewModelArray();

  async loadTasks(context: common.UIAbilityContext) {
    let todoList = new TodoListModel([]);
    await todoList.loadTasks(context);
    for(let things of todoList.things) {
      let thingsViewModel = new ThingsViewModel();
      thingsViewModel.updateTask(things);
      this.things.push(thingsViewModel);
    }
  }

  chooseAll(): void {
    for(let things of this.things) {
      things.isFinish = this.isChoosen;
    }
    this.isChoosen = !this.isChoosen;
  }
}