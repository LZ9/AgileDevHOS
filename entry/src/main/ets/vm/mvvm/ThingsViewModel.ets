import ThingsModel from "../../bean/mvvm/ThingsModel";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
@Observed
export default class ThingsViewModel {
  @Track thingsName: string = 'Todo';
  @Track isFinish: boolean = false;

  updateTask(things: ThingsModel) {
    this.thingsName = things.thingsName;
    this.isFinish = things.isFinish;
  }

  updateIsFinish(): void {
    this.isFinish = !this.isFinish;
  }

  addSuffixes(): void {
    this.thingsName += '啦';
  }
}