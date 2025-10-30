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

    /** 版本19 */
    export const VERSION_19 = 19

    /** 版本20 */
    export const VERSION_20 = 20
  }

  /** 日期格式 */
  export namespace DateFormat {

    export const TYPE_1 = "yyyy-MM-dd HH:mm:ss"

    export const TYPE_2 = "HH:mm"

    export const TYPE_3 = "yyyyMMddHHmmssSSS"

    export const TYPE_4 = "yyyyMMddHHmmss"

    export const TYPE_5 = "yyyyMMdd"

    export const TYPE_6 = "yyyy-MM-dd"

    export const TYPE_7 = "yyyy-MM-dd-HH-mm-ss"

    export const TYPE_8 = "HH:mm:ss"

    export const TYPE_9 = "yyyy-MM-dd HH-mm-ss"

    export const TYPE_10 = "yyyy-MM-dd HH:mm:ss:SSS"

    export const TYPE_11 = "yyyy-MM-dd HH:mm"

    export const TYPE_12 = "yyyyMM"

    export const TYPE_13 = "yyyy-MM"

    export const TYPE_14 = "yyyy"

    export const TYPE_15 = "yyyy年MM月dd日"

    export const TYPE_16 = "yyyy年MM月dd日 HH:mm"

    export const TYPE_17 = "yyyy年MM月dd日 HH:mm:ss"

    export const TYPE_18 = "yyyy年MM月"

    export const TYPE_19 = "MM月dd日"

    export const TYPE_20 = "HH点mm分"

    export const TYPE_21 = "HH点mm分ss秒"

    export const TYPE_22 = "yyyy年MM月dd日 HH点mm分"

    export const TYPE_23 = "yyyy年MM月dd日 HH点mm分ss秒"
  }

  /** 布局参数 */
  export namespace LayoutParams {
    /** 100%充满 */
    export const MATCH_PARENT = '100%'
  }
}
