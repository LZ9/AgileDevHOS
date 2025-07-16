import { promptAction } from "@kit.ArkUI";

/**
 * Core常量配置
 * Created by Admin on 2025/7/15.
 */
export namespace CoreConstants {

  /** 提示时长 */
  export namespace Prompt {
    /** 提示时长 */
    export namespace Duration {
      /** 短时长 */
      export const SHORT = 2000;

      /** 长时长 */
      export const LONG = 3500;
    }

    /** 操作菜单按钮类型 */
    export type MenuBtn = [
      promptAction.Button,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?
    ];
  }

}
