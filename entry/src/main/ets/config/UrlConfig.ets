/**
 * 接口路径配置
 * Created by zhouL on 2025/10/22.
 */
export class UrlConfig {
  /** 华为开发者接口地址 */
  public static readonly RELEASE = 'https://svc-drcn.developer.huawei.com/community/servlet/consumer/partnerActivityService/v1/developer/'
  /** Mock地址 */
  public static readonly TEST_MOCK = 'http://192.168.5.204:38080/app/mock/32/yszz/'

  /** 基地址 */
  public static readonly BASE_URL = UrlConfig.RELEASE
}