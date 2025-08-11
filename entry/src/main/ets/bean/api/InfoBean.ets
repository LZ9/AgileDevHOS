import { InfoItemBean } from "./InfoItemBean"
import { pageInfoBean } from "./pageInfoBean"

/**
 * 数据列表
 * Created by zhouL on 2025/8/11.
 */
export class InfoBean {
  /** 数据列表 */
  public list?: Array<InfoItemBean>
  /** 分页信息 */
  public pageInfo?: pageInfoBean
}
