import { TitleBarViewVm } from "./TitleBarViewVm"

/**
 * 标题栏控件
 * Created by zhouL on 2025/7/23.
 */
@ComponentV2
export struct TitleBarView {
  /** 属性 */
  @Param public vm: TitleBarViewVm = new TitleBarViewVm()
  /** 拓展区域布局 */
  @BuilderParam public expandLayout?: () => void

  build() {
    Column() {
      RelativeContainer() {
        Stack() {
          //返回按钮
          Image(this.vm.backImgVm.src ?? $r('app.media.pandora_ic_back'))
            .width(this.vm.backImgVm.width ?? 20)
            .height(this.vm.backImgVm.height ?? 20)
            .objectFit(this.vm.backImgVm.objectFit ?? ImageFit.Auto)
        }
        .width(50)
        .height('100%')
        .visibility(this.vm.backImgVm.visibility ?? Visibility.Visible)
        .alignRules({
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          center: { anchor: "__container__", align: VerticalAlign.Center },
        })
        .id("back_btn")
        .onClick((event) => {
          if (this.vm.backImgVm.onClick) {
            this.vm.backImgVm.onClick(event)
          }
        })

        //标题
        Text(this.vm.titleVm.title ?? "标题")
          .fontSize(this.vm.titleVm.fontSize ?? 18)
          .textAlign(this.vm.titleVm.textAlign ?? TextAlign.Center)
          .fontColor(this.vm.titleVm.fontColor ?? Color.White)
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
          this.expandLayout?.()
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
      .backgroundColor(this.vm.titleVm.backgroundColor ?? Color.Grey)

      // 分割线
      Line()
        .width('100%')
        .height(1)
        .backgroundColor(this.vm.dividingVm.color ?? Color.Black)
        .visibility(this.vm.dividingVm.visibility ?? Visibility.None)
    }
    .width('100%')
  }
}