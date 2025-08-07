import { ProgressDialogVm } from "./ProgressDialogVm"

/**
 * 加载框弹框
 * Created by zhouL on 2025/8/7.
 */
@Builder
export function ProgressDialog(vm: ProgressDialogVm) {
  Column() {
    LoadingProgress()
      .width(vm.progressVm.width ?? 48)
      .height(vm.progressVm.height ?? 48)
      .color(vm.progressVm.color ?? Color.White)

    Text(vm.textVm.content ?? $r('app.string.pandora_loading'))
      .fontSize(vm.textVm.fontSize ?? 14)
      .fontColor(vm.textVm.fontColor ?? Color.White)
      .margin({ top: 5 })
      .visibility(vm.textVm.visibility ?? Visibility.Visible)
  }
  .constraintSize({
    minWidth: vm.minWidth ?? 100,
    minHeight: vm.minHeight ?? 100
  })
  .justifyContent(FlexAlign.Center)
  .padding(vm.padding ?? 10)
  .backgroundColor(vm.backgroundColor ?? $r('app.color.pandora_color_A6505050'))
  .borderRadius(vm.borderRadius ?? 12)
}

//@CustomDialog
// struct ProgressDialog {
//   controller?: CustomDialogController
//   @Prop message: string = '加载中...'
//
//   build() {
//     Column() {
//       LoadingProgress()
//         .width(48)
//         .height(48)
//         .color(Color.White)
//
//       Text(this.message)
//         .fontSize(14)
//         .fontColor(Color.White)
//         .margin({ top: 5 })
//     }
//     .constraintSize({
//       minWidth: 100,
//       minHeight: 100
//     })
//     .justifyContent(FlexAlign.Center)
//     .padding(10)
//     .backgroundColor($r('app.color.pandora_color_A6505050'))
//     .borderRadius(12)
//   }
// }