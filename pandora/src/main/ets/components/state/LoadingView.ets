/**
 * 加载控件
 * Created by zhouL on 2025/7/23.
 */
@Component
@Preview({ deviceType: "phone" })
export struct LoadingView {
  @State public progressOptions: ProgressOptions = {}
  @State public textOptions: TextOptions = {}

  build() {
    Column() {
      Progress({ value: 0, total: 10, type: ProgressType.Ring })
        .width(this.progressOptions.width !== undefined ? this.progressOptions.width : 50)
        .color(this.progressOptions.color !== undefined ? this.progressOptions.color : Color.Gray)
        .style({
          strokeWidth: this.progressOptions.strokeWidth !== undefined ? this.progressOptions.strokeWidth : 5,
          status: ProgressStatus.LOADING
        })

      Text(this.textOptions.content !== undefined ? this.textOptions.content : $r('app.string.pandora_loading'))
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

/** 返回按钮参数 */
export interface ProgressOptions {
  /** 宽度 */
  width?: Length
  /** 颜色 */
  color?: ResourceColor | LinearGradient
  /** 描边宽度 */
  strokeWidth?: Length
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
  /** 标题栏背景色 */
  backgroundColor?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}