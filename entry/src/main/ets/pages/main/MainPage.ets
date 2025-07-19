import { RouterUtils } from 'pandora'
import { MainBean } from '../../bean/main/MainBean'

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
      new MainBean("Json转换测试", $r('app.string.json_page_path')),
      new MainBean("Preferences测试类", $r('app.string.preferences_page_path'))
    ]
  }

  build() {
    List() {
      ForEach(this.mList, (item: MainBean) => {
        ListItem() {
          Text(item.getTitleName())
            .fontSize(24)
            .onClick(() => {
              RouterUtils.pushUrl(this.getUIContext(), item.getPagePath(this.getUIContext()))
            })
        }
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
  }
}