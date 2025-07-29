import ThingsModel from "./ThingsModel";
import { common } from "@kit.AbilityKit";
import { util } from "@kit.ArkTS";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
export default class TodoListModel {
  things: Array<ThingsModel> = [];

  constructor(things: Array<ThingsModel>) {
    this.things = things;
  }

  async loadTasks(context: common.UIAbilityContext) {
    let getJson = await context.resourceManager.getRawFileContent('defaultTasks.json');
    let textDecoderOptions: util.TextDecoderOptions = { ignoreBOM: true };
    let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
    let result = textDecoder.decodeToString(getJson, { stream: false });
    this.things = JSON.parse(result);
  }
}