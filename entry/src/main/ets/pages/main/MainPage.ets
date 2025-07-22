import { PromptUtils, RouterUtils, StatusBarUtils } from 'pandora'
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
    StatusBarUtils.getInstance().setColor(this.getUIContext().getHostContext(), $r('app.color.color_00a0e9'), Color.White)
  }

  build() {
    Column() {
      //标题栏
      Column() {
        RelativeContainer() {

          //返回按钮
          Image($r('sys.media.ohos_ic_compnent_titlebar_back'))
            .width(40)
            .height(`100%`)
            .objectFit(ImageFit.Auto)
            .alignRules({
              left: { anchor: "__container__", align: HorizontalAlign.Start },
              center: { anchor: "__container__", align: VerticalAlign.Center },
            })
            .id("back_btn")
            .onClick(() => {
              PromptUtils.toastShort(this.getUIContext(), '返回')
            })

          //标题
          Text('Pandora DemoDem')
            .fontSize(24)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Black)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .id("title")
            .alignRules({
              left: { anchor: "back_btn", align: HorizontalAlign.End },
              right: { anchor: "expand", align: HorizontalAlign.Start },
              center: { anchor: "__container__", align: VerticalAlign.Center },
              // bias: { horizontal: 0 }
            })

          //拓展区域
          Row(){
            Image($r('sys.media.ic_grid_pdf'))
              .objectFit(ImageFit.Auto)
              .height(`100%`)
              .onClick(() => {
                PromptUtils.toastShort(this.getUIContext(), '返回')
              })
          }
          .width(40)
          .height('100%')
          .id("expand")
          .alignRules({
            right: { anchor: "__container__", align: HorizontalAlign.End },
            center: { anchor: "__container__", align: VerticalAlign.Center }
          })
        }
        .width('100%')
        .height(56)

        // 分割线
        Line()
          .width('100%')
          .height(1)
          .backgroundColor(Color.Black)
      }
      .width('100%')
      .backgroundColor($r('app.color.color_00a0e9'))











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

