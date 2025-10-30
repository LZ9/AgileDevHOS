import { CoreConstants } from "@lodz/core_hos"
import { NoDataViewVm } from "./NoDataViewVm"

/**
 * 无数据控件
 * Created by zhouL on 2025/7/24.
 */
@ComponentV2
export struct NoDataView {
  /** 属性 */
  @Param public vm: NoDataViewVm = new NoDataViewVm()

  build() {
    Column() {
      Image(this.vm.imgVm.src ?? $r('app.media.pandora_ic_no_data'))
        .width(this.vm.imgVm.width ?? 200)
        .height(this.vm.imgVm.height ?? 200)
        .objectFit(this.vm.imgVm.objectFit ?? ImageFit.Auto)
        .visibility(this.vm.imgVm.visibility ?? Visibility.Visible)

      Text(this.vm.textVm.content ?? $r('app.string.pandora_no_data'))
        .fontSize(this.vm.textVm.fontSize ?? 14)
        .fontColor(this.vm.textVm.fontColor ?? Color.Gray)
        .textAlign(this.vm.textVm.textAlign ?? TextAlign.Center)
        .visibility(this.vm.textVm.visibility ?? Visibility.Visible)
        .margin(10)
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .backgroundColor(this.vm.textVm.backgroundColor ?? Color.White)
    .justifyContent(FlexAlign.Center) // 垂直居中
    .alignItems(HorizontalAlign.Center) // 水平居中
  }
}