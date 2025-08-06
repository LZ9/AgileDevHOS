import { LoadingViewVm } from "./LoadingViewVm"

/**
 * 加载控件
 * Created by zhouL on 2025/7/23.
 */
@ComponentV2
@Preview({ deviceType: "phone" })
export struct LoadingView {
  /** 属性 */
  @Param public vm: LoadingViewVm = new LoadingViewVm()

  build() {
    Column() {
      LoadingProgress()
        .width(this.vm.progressVm.width ?? 50)
        .color(this.vm.progressVm.color ?? Color.Gray)

      Text(this.vm.textVm.content ?? $r('app.string.pandora_loading'))
        .fontSize(this.vm.textVm.fontSize ?? 14)
        .fontColor(this.vm.textVm.fontColor ?? Color.Gray)
        .textAlign(this.vm.textVm.textAlign ?? TextAlign.Center)
        .visibility(this.vm.textVm.visibility ?? Visibility.Visible)
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.vm.textVm.backgroundColor ?? Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}