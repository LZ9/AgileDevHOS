import { ResourceUtils, RouterUtils } from 'pandora'
import { MainBean } from '../../bea/main/MainBean'

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
export struct MainPage {
  private mList: Array<MainBean> = []

  aboutToAppear(): void {
    this.mList = [
      new MainBean("Json转换测试", $r('app.string.json_page_path'))
    ]
  }

  build() {
    List() {
      ForEach(this.mList, (item: MainBean) => {
        ListItem() {
          Text(item.getTitleName())
            .fontSize(24)
            .onClick(() => {
              RouterUtils.pushUrl(this.getUIContext(), ResourceUtils.toString(this.getUIContext().getHostContext(), item.getPageRes()))
            })
        }
      })
    }
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
  }
}