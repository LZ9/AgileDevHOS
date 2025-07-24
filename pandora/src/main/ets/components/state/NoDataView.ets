import { NoDataViewAttribute } from "./NoDataViewAttribute"

/**
 * 无数据控件
 * Created by zhouL on 2025/7/24.
 */
@Component
export struct NoDataView {

  /** 属性 */
  @State public attribute: NoDataViewAttribute = new NoDataViewAttribute()

  build() {
    Column() {
      Image(this.attribute.imgOptions.src !== undefined ? this.attribute.imgOptions.src : $r('app.media.pandora_ic_no_data'))
        .width(this.attribute.imgOptions.width !== undefined ? this.attribute.imgOptions.width : 200)
        .height(this.attribute.imgOptions.height !== undefined ? this.attribute.imgOptions.height : 200)
        .objectFit(this.attribute.imgOptions.objectFit !== undefined ? this.attribute.imgOptions.objectFit : ImageFit.Auto)
        .visibility(this.attribute.imgOptions.visibility !== undefined ? this.attribute.imgOptions.visibility : Visibility.Visible)

      Text(this.attribute.textOptions.content !== undefined ? this.attribute.textOptions.content : $r('app.string.pandora_no_data'))
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