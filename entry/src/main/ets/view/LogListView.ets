import { CoreConstants, DateUtils, DeviceUtils } from "@lodz/pandora";

/**
 * 日志列表控件
 * Created by zhouL on 2025/7/25.
 */
@Component
export struct LogListView {
  /** 日志列表 */
  @Link
  @Watch('onListChange')
  public logList: Array<string>
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
      .width('100%')
      .height('100%')
      .alignListItem(ListItemAlign.Start)
    }
  }

  /** 列表数据变化 */
  onListChange() {
    this.listScroller.scrollTo({ xOffset: 0, yOffset: DeviceUtils.getScreenHeight(), animation: true })
  }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_1) + " : " + text)

  }
}