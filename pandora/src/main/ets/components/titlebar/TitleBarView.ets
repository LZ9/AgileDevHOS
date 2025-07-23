/**
 * 标题栏控件
 * Created by zhouL on 2025/7/23.
 */
@Component
export struct TitleBarView {
  @State public backImgOptions: BackImgOptions = {}
  @State public titleOptions: TitleOptions = {}
  @State public dividingOptions: DividingOptions = {}

  // 拓展区域布局
  @BuilderParam expandLayout?: () => void

  build() {
    Column() {
      RelativeContainer() {
        Stack() {
          //返回按钮
          Image(this.backImgOptions.src !== undefined ? this.backImgOptions.src : $r('app.media.pandora_ic_back'))
            .width(this.backImgOptions.width !== undefined ? this.backImgOptions.width : 20)
            .height(this.backImgOptions.height !== undefined ? this.backImgOptions.height : 20)
            .objectFit(this.backImgOptions.objectFit !== undefined ? this.backImgOptions.objectFit : ImageFit.Auto)
        }
        .width(50)
        .height('100%')
        .visibility(this.backImgOptions.visibility !== undefined ? this.backImgOptions.visibility : Visibility.Visible)
        .alignRules({
          left: { anchor: "__container__", align: HorizontalAlign.Start },
          center: { anchor: "__container__", align: VerticalAlign.Center },
        })
        .id("back_btn")
        .onClick((event) => {
          if (this.backImgOptions.onClick) {
            this.backImgOptions.onClick(event)
          }
        })

        //标题
        Text(this.titleOptions.title !== undefined ? this.titleOptions.title : "标题")
          .fontSize(this.titleOptions.fontSize !== undefined ? this.titleOptions.fontSize : 20)
          .textAlign(this.titleOptions.textAlign !== undefined ? this.titleOptions.textAlign : TextAlign.Center)
          .fontColor(this.titleOptions.fontColor !== undefined ? this.titleOptions.fontColor : Color.White)
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
      .backgroundColor(this.titleOptions.backgroundColor !== undefined ? this.titleOptions.backgroundColor : Color.Grey)

      // 分割线
      Line()
        .width('100%')
        .height(1)
        .backgroundColor(this.dividingOptions.color !== undefined ? this.dividingOptions.color :Color.Black)
        .visibility(this.dividingOptions.visibility !== undefined ? this.dividingOptions.visibility : Visibility.None)
    }
    .width('100%')
  }
}

/** 返回按钮参数 */
export interface BackImgOptions {
  /** 图片 */
  src ?: PixelMap | ResourceStr | DrawableDescriptor | ImageContent
  /** 宽度 */
  width?: Length
  /** 高度 */
  height?: Length
  /** 图片填充效果 */
  objectFit?: ImageFit
  /** 控件显隐 */
  visibility?: Visibility
  /** 点击监听器 */
  onClick?: (event: ClickEvent) => void
}

/** 标题参数 */
export interface TitleOptions {
  /** 标题文字 */
  title?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字位置 */
  textAlign?: TextAlign
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 标题栏背景色 */
  backgroundColor?: ResourceColor
}

/** 分割线参数 */
export interface DividingOptions {
  /** 分割线颜色 */
  color?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}