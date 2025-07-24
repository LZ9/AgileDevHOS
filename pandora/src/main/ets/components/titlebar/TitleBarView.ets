import { TitleBarAttribute } from "./TitleBarAttribute"

/**
 * 标题栏控件
 * Created by zhouL on 2025/7/23.
 */
@Component
export struct TitleBarView {

  /** 标题栏属性 */
  @Link public attribute: TitleBarAttribute
  // 拓展区域布局
  @BuilderParam public expandLayout?: () => void

  build() {
    Column() {
      RelativeContainer() {
        Stack() {
          //返回按钮
          Image(this.attribute.backImgOptions.src !== undefined ? this.attribute.backImgOptions.src : $r('app.media.pandora_ic_back'))
            .width(this.attribute.backImgOptions.width !== undefined ? this.attribute.backImgOptions.width : 20)
            .height(this.attribute.backImgOptions.height !== undefined ? this.attribute.backImgOptions.height : 20)
            .objectFit(this.attribute.backImgOptions.objectFit !== undefined ? this.attribute.backImgOptions.objectFit : ImageFit.Auto)
        }
        .width(50)
        .height('100%')
        .visibility(this.attribute.backImgOptions.visibility !== undefined ? this.attribute.backImgOptions.visibility : Visibility.Visible)
        .alignRules({
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          center: { anchor: "__container__", align: VerticalAlign.Center },
        })
        .id("back_btn")
        .onClick((event) => {
          if (this.attribute.backImgOptions.onClick) {
            this.attribute.backImgOptions.onClick(event)
          }
        })

        //标题
        Text(this.attribute.titleOptions.title !== undefined ? this.attribute.titleOptions.title : "标题")
          .fontSize(this.attribute.titleOptions.fontSize !== undefined ? this.attribute.titleOptions.fontSize : 20)
          .textAlign(this.attribute.titleOptions.textAlign !== undefined ? this.attribute.titleOptions.textAlign : TextAlign.Center)
          .fontColor(this.attribute.titleOptions.fontColor !== undefined ? this.attribute.titleOptions.fontColor : Color.White)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .id("title")
          .alignRules({
            left: { anchor: "back_btn", align: HorizontalAlign.End },
            right: { anchor: "expand", align: HorizontalAlign.Start },
            center: { anchor: "__container__", align: VerticalAlign.Center },
          })

        //拓展区域
        Row() {
          if (this.expandLayout) {
            this.expandLayout()
          }
        }
        .width(this.expandLayout !== undefined ? 'auto' : 50)
        .height('100%')
        .id("expand")
        .alignRules({
          right: { anchor: "__container__", align: HorizontalAlign.End },
          center: { anchor: "__container__", align: VerticalAlign.Center }
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.attribute.titleOptions.backgroundColor !== undefined ? this.attribute.titleOptions.backgroundColor : Color.Grey)

      // 分割线
      Line()
        .width('100%')
        .height(1)
        .backgroundColor(this.attribute.dividingOptions.color !== undefined ? this.attribute.dividingOptions.color :Color.Black)
        .visibility(this.attribute.dividingOptions.visibility !== undefined ? this.attribute.dividingOptions.visibility : Visibility.None)
    }
    .width('100%')
  }
}