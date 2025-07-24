import { ErrorView } from "../../components/state/ErrorView"
import { LoadingView } from "../../components/state/LoadingView"
import { NoDataView } from "../../components/state/NoDataView"
import { TitleBarView } from "../../components/titlebar/TitleBarView"
import { BaseContainerAttribute } from "./BaseContainerAttribute"

/**
 * 页面基类
 * Created by zhouL on 2025/7/14.
 */
@Component
export struct BaseContainer {
  // 属性
  @State public attribute: BaseContainerAttribute = new BaseContainerAttribute()

  // 内容布局
  @BuilderParam public contentLayout?: () => void

  build() {
    Column() {
      TitleBarView({ attribute: this.attribute.titleBarAttribute })
        .visibility(this.attribute.isShowTitleBar ? Visibility.Visible : Visibility.None)

      LoadingView({ attribute: this.attribute.loadingAttribute })
        .width(`100%`)
        .height(`100%`)
        .visibility(this.attribute.isShowLoading ? Visibility.Visible : Visibility.None)


      NoDataView({ attribute: this.attribute.noDataAttribute })
        .width(`100%`)
        .height(`100%`)
        .visibility(this.attribute.isShowNoData ? Visibility.Visible : Visibility.None)

      ErrorView({ attribute: this.attribute.errorAttribute })
        .width(`100%`)
        .height(`100%`)
        .visibility(this.attribute.isShowError ? Visibility.Visible : Visibility.None)
        .onClick((event) => {
          if (this.attribute.onReloadClick) {
            this.attribute.onReloadClick(event)
          }
        })

      Stack() {
        if (this.contentLayout) {
          this.contentLayout()
        }
      }
      .width(`100%`)
      .height(`100%`)
      .visibility(this.attribute.isShowContent ? Visibility.Visible : Visibility.None)
    }
    .width(`100%`)
    .height(`100%`)
  }
}

