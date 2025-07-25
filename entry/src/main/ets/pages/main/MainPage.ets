import { PromptUtils, RouterUtils, StatusBarUtils, TitleBarViewAttribute, TitleBarView } from 'pandora'
import { MainBean } from '../../bean/main/MainBean'

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
export struct MainPage {
  /** 列表数据 */
  private list: Array<MainBean> = []
  /** 标题栏属性 */
  @State attribute: TitleBarViewAttribute = new TitleBarViewAttribute()

  aboutToAppear(): void {
    //设置状态栏颜色
    StatusBarUtils.setColor(this.getUIContext().getHostContext(), $r('app.color.color_00a0e9'), Color.White)
    this.attribute = this.configTitleBarViewAttribute()

    this.list = [
      new MainBean("Json转换测试", $r('app.string.json_page_path')),
      new MainBean("Preferences测试类", $r('app.string.preferences_page_path'))
    ]
  }

  /** 配置标题栏熟悉 */
  private configTitleBarViewAttribute(): TitleBarViewAttribute {
    const attribute = new TitleBarViewAttribute()
    attribute.backImgOptions.visibility = Visibility.Hidden
    attribute.titleOptions.title = $r('app.string.main_title')
    attribute.titleOptions.backgroundColor = $r('app.color.color_00a0e9')
    return attribute
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
      TitleBarView({ attribute: this.attribute, expandLayout: this.expandLayout })

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

