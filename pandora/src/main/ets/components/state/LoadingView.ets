import { LoadingViewVm } from "./LoadingViewVm"

/**
 * 加载控件
 * Created by zhouL on 2025/7/23.
 */
@Component
@Preview({ deviceType: "phone" })
export struct LoadingView {
  /** 属性 */
  @State public vm: LoadingViewVm = new LoadingViewVm()

  build() {
    Column() {
      Progress({ value: 0, total: 10, type: ProgressType.Ring })
        .width(this.vm.progressOptions.width !== undefined ? this.vm.progressOptions.width : 50)
        .color(this.vm.progressOptions.color !== undefined ? this.vm.progressOptions.color : Color.Gray)
        .style({
          strokeWidth: this.vm.progressOptions.strokeWidth !== undefined ? this.vm.progressOptions.strokeWidth : 5,
          status: ProgressStatus.LOADING
        })

      Text(this.vm.textOptions.content !== undefined ? this.vm.textOptions.content : $r('app.string.pandora_loading'))
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