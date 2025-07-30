import { ErrorViewVm } from "./ErrorViewVm"

/**
 * 加载失败控件
 * Created by zhouL on 2025/7/24.
 */
@Component
export struct ErrorView {

  /** 属性 */
  @State public vm: ErrorViewVm = new ErrorViewVm()

  build() {
    Column() {
      Image(this.vm.imgOptions.src !== undefined ? this.vm.imgOptions.src : $r('app.media.pandora_ic_data_fail'))
        .width(this.vm.imgOptions.width !== undefined ? this.vm.imgOptions.width : 200)
        .height(this.vm.imgOptions.height !== undefined ? this.vm.imgOptions.height : 200)
        .objectFit(this.vm.imgOptions.objectFit !== undefined ? this.vm.imgOptions.objectFit : ImageFit.Auto)
        .visibility(this.vm.imgOptions.visibility !== undefined ? this.vm.imgOptions.visibility : Visibility.Visible)

      Text(this.vm.textOptions.content !== undefined ? this.vm.textOptions.content : $r('app.string.pandora_load_fail'))
        .fontSize(this.vm.textOptions.fontSize !== undefined ? this.vm.textOptions.fontSize : 14)
        .fontColor(this.vm.textOptions.fontColor !== undefined ? this.vm.textOptions.fontColor : Color.Gray)
        .textAlign(this.vm.textOptions.textAlign !== undefined ? this.vm.textOptions.textAlign : TextAlign.Center)
        .visibility(this.vm.textOptions.visibility !== undefined ? this.vm.textOptions.visibility : Visibility.Visible)
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.vm.textOptions.backgroundColor !== undefined ? this.vm.textOptions.backgroundColor : Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}