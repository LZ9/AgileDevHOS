/**
 * 加载失败控件
 * Created by zhouL on 2025/7/24.
 */
@Component
export struct ErrorView {
  /** 图片参数 */
  @State public imgOptions: ImgOptions = {}
  /** 文字参数 */
  @State public textOptions: TextOptions = {}

  build() {
    Column() {
      Image(this.imgOptions.src !== undefined ? this.imgOptions.src : $r('app.media.pandora_ic_data_fail'))
        .width(this.imgOptions.width !== undefined ? this.imgOptions.width : 200)
        .height(this.imgOptions.height !== undefined ? this.imgOptions.height : 200)
        .objectFit(this.imgOptions.objectFit !== undefined ? this.imgOptions.objectFit : ImageFit.Auto)
        .visibility(this.imgOptions.visibility !== undefined ? this.imgOptions.visibility : Visibility.Visible)

      Text(this.textOptions.content !== undefined ? this.textOptions.content : $r('app.string.pandora_load_fail'))
        .fontSize(this.textOptions.fontSize !== undefined ? this.textOptions.fontSize : 14)
        .fontColor(this.textOptions.fontColor !== undefined ? this.textOptions.fontColor : Color.Gray)
        .textAlign(this.textOptions.textAlign !== undefined ? this.textOptions.textAlign : TextAlign.Center)
        .visibility(this.textOptions.visibility !== undefined ? this.textOptions.visibility : Visibility.Visible)
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.textOptions.backgroundColor !== undefined ? this.textOptions.backgroundColor : Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}

/** 图片参数 */
export interface ImgOptions {
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
}

/** 文字参数 */
export interface TextOptions {
  /** 文字 */
  content?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 文字位置 */
  textAlign?: TextAlign
  /** 背景色 */
  backgroundColor?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}