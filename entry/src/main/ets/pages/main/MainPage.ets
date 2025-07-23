import { PromptUtils, RouterUtils, StatusBarUtils, TitleBarView } from 'pandora'
import { MainBean } from '../../bean/main/MainBean'

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
export struct MainPage {
  private list: Array<MainBean> = []

  aboutToAppear(): void {
    this.list = [
      new MainBean("Json转换测试", $r('app.string.json_page_path')),
      new MainBean("Preferences测试类", $r('app.string.preferences_page_path'))
    ]
    //设置状态栏颜色
    StatusBarUtils.getInstance().setColor(this.getUIContext().getHostContext(), $r('app.color.color_00a0e9'), Color.White)
  }

  @Builder
  expandLayout() {
    Text($r('app.string.main_change_mood'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })
      .onClick(() => {
        PromptUtils.toastShort(this.getUIContext(), "刷新")
      })
  }

  build() {
    Column() {
      TitleBarView({
        backImgOptions: {
          visibility: Visibility.Hidden
        },
        titleOptions: {
          title: $r('app.string.main_title'),
          backgroundColor: $r('app.color.color_00a0e9')
        },
        expandLayout: this.expandLayout
      })

      // 列表
      List() {
        ForEach(this.list, (item: MainBean) => {
          ListItem() {
            Text(item.getTitleName())
              .width('100%')
              .fontSize(20)
              .textAlign(TextAlign.Start)
              .padding(10)
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

