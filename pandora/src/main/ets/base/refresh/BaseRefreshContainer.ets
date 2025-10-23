import { ErrorView } from "../../components/state/error/ErrorView"
import { LoadingView } from "../../components/state/loading/LoadingView"
import { NoDataView } from "../../components/state/nodata/NoDataView"
import { TitleBarView } from "../../components/titlebar/TitleBarView"
import { BaseRefreshContainerVm } from "./BaseRefreshContainerVm"

/**
 * 基类刷新容器控件
 * Created by zhouL on 2025/10/13.
 */
@ComponentV2
export struct BaseRefreshContainer {
  /** 属性 */
  @Param public vm: BaseRefreshContainerVm = new BaseRefreshContainerVm()
  /** 内容布局 */
  @BuilderParam public contentLayout?: () => void
  /** 内容布局 */
  @BuilderParam public titleBarExpandLayout?: () => void
  /** 自定义拖拽动画布局 */
  @BuilderParam public refreshHeaderLayout?: () => CustomBuilder

  aboutToAppear(): void {
    this.vm.loadMoreAgent.setOnLoadingStatusChangeListener((status) => {
      this.vm.loadingStatus = status
    })
  }

  build() {
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

      Refresh({
        refreshing: $$this.vm.isRefreshing,
        friction: this.vm.refreshFriction,
        promptText: this.vm.refreshPromptText,
        builder: this.refreshHeaderLayout ?? undefined,
        refreshingContent: this.vm.refreshingContent,
      }) {
        this.contentLayout?.()
      }
      .width(`100%`)
      .layoutWeight(1)
      .refreshOffset(this.vm.refreshOffset)
      .pullToRefresh(true)
      .pullDownRatio(this.vm.isEnableRefresh ? undefined : 0)
      .backgroundColor(this.vm.refreshBackgroundColor ?? Color.White)
      .onOffsetChange((offset: number) => {
        if (this.vm.onOffsetChange) {
          this.vm.onOffsetChange(offset)
        }
      })
      .onStateChange((state: RefreshStatus) => {
        if (this.vm.onStateChange) {
          this.vm.onStateChange(state)
        }
      })
      .onRefreshing(() => {
        if (this.vm.onRefreshing) {
          this.vm.onRefreshing()
        }
      })
      .visibility(this.vm.isShowContent ? Visibility.Visible : Visibility.None)
    }
    .width(`100%`)
    .height(`100%`)
  }
}