import { ErrorViewVm } from "./ErrorViewVm"

/**
 * 加载失败控件
 * Created by zhouL on 2025/7/24.
 */
@ComponentV2
export struct ErrorView {

  /** 属性 */
  @Param public vm: ErrorViewVm = new ErrorViewVm()

  build() {
    Column() {
      Image(this.vm.imgVm.src !== undefined ? this.vm.imgVm.src : $r('app.media.pandora_ic_data_fail'))
        .width(this.vm.imgVm.width !== undefined ? this.vm.imgVm.width : 200)
        .height(this.vm.imgVm.height !== undefined ? this.vm.imgVm.height : 200)
        .objectFit(this.vm.imgVm.objectFit !== undefined ? this.vm.imgVm.objectFit : ImageFit.Auto)
        .visibility(this.vm.imgVm.visibility !== undefined ? this.vm.imgVm.visibility : Visibility.Visible)

      Text(this.vm.textVm.content !== undefined ? this.vm.textVm.content : $r('app.string.pandora_load_fail'))
        .fontSize(this.vm.textVm.fontSize !== undefined ? this.vm.textVm.fontSize : 14)
        .fontColor(this.vm.textVm.fontColor !== undefined ? this.vm.textVm.fontColor : Color.Gray)
        .textAlign(this.vm.textVm.textAlign !== undefined ? this.vm.textVm.textAlign : TextAlign.Center)
        .visibility(this.vm.textVm.visibility !== undefined ? this.vm.textVm.visibility : Visibility.Visible)
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.vm.textVm.backgroundColor !== undefined ? this.vm.textVm.backgroundColor : Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}