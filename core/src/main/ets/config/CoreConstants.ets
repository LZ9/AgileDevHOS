import { promptAction } from "@kit.ArkUI"

/**
 * Core常量配置
 * Created by zhouL on 2025/7/15.
 */
export namespace CoreConstants {

  /** 提示时长 */
  export namespace Prompt {
    /** 提示时长 */
    export namespace Duration {
      /** 短时长 */
      export const SHORT = 2000

      /** 长时长 */
      export const LONG = 3500
    }

    /** 操作菜单按钮类型 */
    export type MenuBtn = [
      promptAction.Button,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?,
      promptAction.Button?
    ]
  }

  /** SDK的api版本 */
  export namespace SdkApiVersion {
    /** 版本10 */
    export const VERSION_10 = 10

    /** 版本11 */
    export const VERSION_11 = 11

    /** 版本12 */
    export const VERSION_12 = 12

    /** 版本13 */
    export const VERSION_13 = 13

    /** 版本14 */
    export const VERSION_14 = 14

    /** 版本15 */
    export const VERSION_15 = 15

    /** 版本16 */
    export const VERSION_16 = 16

    /** 版本17 */
    export const VERSION_17 = 17

    /** 版本18 */
    export const VERSION_18 = 18
  }
}
