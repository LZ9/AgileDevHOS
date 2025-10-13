import { ActivityListItemBean } from "./ActivityListItemBean"
import { pageInfoBean } from "./pageInfoBean"

/**
 * 数据列表
 * Created by zhouL on 2025/8/11.
 */
export class ActivityListBean {
  /** 数据列表 */
  public list?: Array<ActivityListItemBean>
  /** 分页信息 */
  public pageInfo?: pageInfoBean
}
