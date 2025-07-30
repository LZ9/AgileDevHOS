import { TitleBarViewVm } from "./TitleBarViewVm"

/**
 * 标题栏控件
 * Created by zhouL on 2025/7/23.
 */
@Component
export struct TitleBarView {

  /** 属性 */
  @State public vm: TitleBarViewVm = new TitleBarViewVm()
  /** 拓展区域布局 */
  @BuilderParam public expandLayout?: () => void

  build() {
    Column() {
      RelativeContainer() {
        Stack() {
          //返回按钮
          Image(this.vm.backImgOptions.src !== undefined ? this.vm.backImgOptions.src : $r('app.media.pandora_ic_back'))
            .width(this.vm.backImgOptions.width !== undefined ? this.vm.backImgOptions.width : 20)
            .height(this.vm.backImgOptions.height !== undefined ? this.vm.backImgOptions.height : 20)
            .objectFit(this.vm.backImgOptions.objectFit !== undefined ? this.vm.backImgOptions.objectFit : ImageFit.Auto)
        }
        .width(50)
        .height('100%')
        .visibility(this.vm.backImgOptions.visibility !== undefined ? this.vm.backImgOptions.visibility : Visibility.Visible)
        .alignRules({
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          center: { anchor: "__container__", align: VerticalAlign.Center },
        })
        .id("back_btn")
        .onClick((event) => {
          if (this.vm.backImgOptions.onClick) {
            this.vm.backImgOptions.onClick(event)
          }
        })

        //标题
        Text(this.vm.titleOptions.title !== undefined ? this.vm.titleOptions.title : "标题")
          .fontSize(this.vm.titleOptions.fontSize !== undefined ? this.vm.titleOptions.fontSize : 20)
          .textAlign(this.vm.titleOptions.textAlign !== undefined ? this.vm.titleOptions.textAlign : TextAlign.Center)
          .fontColor(this.vm.titleOptions.fontColor !== undefined ? this.vm.titleOptions.fontColor : Color.White)
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
      .backgroundColor(this.vm.titleOptions.backgroundColor !== undefined ? this.vm.titleOptions.backgroundColor : Color.Grey)

      // 分割线
      Line()
        .width('100%')
        .height(1)
        .backgroundColor(this.vm.dividingOptions.color !== undefined ? this.vm.dividingOptions.color :Color.Black)
        .visibility(this.vm.dividingOptions.visibility !== undefined ? this.vm.dividingOptions.visibility : Visibility.None)
    }
    .width('100%')
  }
}