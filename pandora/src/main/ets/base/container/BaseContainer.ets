import { ErrorView } from "../../components/state/error/ErrorView"
import { LoadingView } from "../../components/state/loading/LoadingView"
import { NoDataView } from "../../components/state/nodata/NoDataView"
import { TitleBarView } from "../../components/titlebar/TitleBarView"
import { NavDesContainer } from "../nav/NavDesContainer"
import { BaseContainerVm } from "./BaseContainerVm"

/**
 * 基类容器控件
 * Created by zhouL on 2025/7/14.
 */
@ComponentV2
export struct BaseContainer {
  /** 属性 */
  @Param public vm: BaseContainerVm = new BaseContainerVm()
  /** 内容布局 */
  @BuilderParam public contentLayout?: () => void
  /** 内容布局 */
  @BuilderParam public titleBarExpandLayout?: () => void

  build() {
    NavDesContainer({
      vm: this.vm.navVm,
      contentLayout: () => {
        this.contentComponent()
      }
    })
      .width(`100%`)
      .height(`100%`)
  }

  @Builder
  private contentComponent() {
    Column() {
      TitleBarView({ vm: this.vm.titleBarViewVm, expandLayout: this.titleBarExpandLayout })
        .visibility(this.vm.isShowTitleBar ? Visibility.Visible : Visibility.None)

      LoadingView({ vm: this.vm.loadingViewVm })
        .width(`100%`)
        .layoutWeight(1)
        .visibility(this.vm.isShowLoading ? Visibility.Visible : Visibility.None)

      NoDataView({ vm: this.vm.noDataViewVm })
        .width(`100%`)
        .layoutWeight(1)
        .visibility(this.vm.isShowNoData ? Visibility.Visible : Visibility.None)

      ErrorView({ vm: this.vm.errorViewVm })
        .width(`100%`)
        .layoutWeight(1)
        .visibility(this.vm.isShowError ? Visibility.Visible : Visibility.None)
        .onClick((event) => {
          if (this.vm.onReloadClick) {
            this.vm.onReloadClick(event)
          }
        })

      Stack() {
        this.contentLayout?.()
      }
      .width(`100%`)
      .layoutWeight(1)
      .visibility(this.vm.isShowContent ? Visibility.Visible : Visibility.None)
    }
    .width(`100%`)
    .height(`100%`)
  }
}

