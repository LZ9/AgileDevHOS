import { LoadingViewAttribute } from "./LoadingViewAttribute"

/**
 * 加载控件
 * Created by zhouL on 2025/7/23.
 */
@Component
@Preview({ deviceType: "phone" })
export struct LoadingView {
  /** 属性 */
  @State public attribute: LoadingViewAttribute = new LoadingViewAttribute()

  build() {
    Column() {
      Progress({ value: 0, total: 10, type: ProgressType.Ring })
        .width(this.attribute.progressOptions.width !== undefined ? this.attribute.progressOptions.width : 50)
        .color(this.attribute.progressOptions.color !== undefined ? this.attribute.progressOptions.color : Color.Gray)
        .style({
          strokeWidth: this.attribute.progressOptions.strokeWidth !== undefined ? this.attribute.progressOptions.strokeWidth : 5,
          status: ProgressStatus.LOADING
        })

      Text(this.attribute.textOptions.content !== undefined ? this.attribute.textOptions.content : $r('app.string.pandora_loading'))
        .fontSize(this.attribute.textOptions.fontSize !== undefined ? this.attribute.textOptions.fontSize : 14)
        .fontColor(this.attribute.textOptions.fontColor !== undefined ? this.attribute.textOptions.fontColor : Color.Gray)
        .textAlign(this.attribute.textOptions.textAlign !== undefined ? this.attribute.textOptions.textAlign : TextAlign.Center)
        .visibility(this.attribute.textOptions.visibility !== undefined ? this.attribute.textOptions.visibility : Visibility.Visible)
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.attribute.textOptions.backgroundColor !== undefined ? this.attribute.textOptions.backgroundColor : Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}