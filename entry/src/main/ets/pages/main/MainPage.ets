import { RouterUtils, StatusBarUtils } from 'pandora'
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
    //设置状态栏颜色
    StatusBarUtils.getInstance().setColor('#0A59F7', '#fff00f')
  }

  build() {
    Column() {
      //标题栏
      Column() {
        Row() {
          Text('Pandora Demo')
            .fontSize(32)
            .fontColor('#000000')
        }
        .width('100%')
        .height(56)
        .backgroundColor(Color.Pink)

        // 分割线
        Line()
          .width('100%')
          .height(1)
          .backgroundColor(Color.Black)
      }.width('100%')

      // 列表
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
}

