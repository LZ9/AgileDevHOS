/**
 * 常量配置
 * Created by zhouL on 2025/7/12.
 */
export namespace Constants {


  /** 接口路径 */
  export namespace ApiUrl {
    /** 正式地址 */
    const RELEASE = 'https://svc-drcn.developer.huawei.com/community/servlet/consumer/partnerActivityService/v1/developer/'

    /** Mock地址 */
    const TEST_MOCK = 'http://192.168.5.204:38080/app/mock/32/yszz/'

    /** 基地址 */
    export const BASE_URL = RELEASE
  }

  /** 日志相关 */
  export namespace Log {
    /** 一般日志标签 */
    export const TAG = 'testTag'

    /** 接口日志标签 */
    export const TAG_API = 'resultValue'
  }

  /** 缓存 */
  export namespace Preferences {
    /** 姓名 */
    export const GITHUB_KEY = 'github_key'
    /** 用户 */
    export const USER_KEY = 'user_key'
  }

}
