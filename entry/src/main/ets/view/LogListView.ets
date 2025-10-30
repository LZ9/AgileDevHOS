import { CoreConstants, DeviceUtils } from "@lodz/pandora";

/**
 * 日志列表控件
 * Created by zhouL on 2025/7/25.
 */
@ComponentV2
export struct LogListView {
  /** 日志列表 */
  @Param public logList: Array<string> = []

  /** 监听日志数据变化 */
  @Monitor('logList.length')//由于Array、Map、Date、Set不能被监听，所以通过监听数组长度的变化来曲线救国
  onLogChange(monitor: IMonitor) {
    this.listScroller.scrollTo({ xOffset: 0, yOffset: DeviceUtils.getScreenHeight(), animation: true })
  }

  /** 列表滚动栏 */
  private listScroller: ListScroller = new ListScroller();

  build() {
    Stack() {
      List({ scroller: this.listScroller }) {
        ForEach(this.logList, (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(14)
              .padding(5)
          }
        })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .height(CoreConstants.LayoutParams.MATCH_PARENT)
      .alignListItem(ListItemAlign.Start)
    }
  }
}