import { ErrorAttribute } from "../../components/state/ErrorAttribute"
import { ErrorView } from "../../components/state/ErrorView"
import { LoadingAttribute } from "../../components/state/LoadingAttribute"
import { LoadingView } from "../../components/state/LoadingView"
import { NoDataAttribute } from "../../components/state/NoDataAttribute"
import { NoDataView } from "../../components/state/NoDataView"
import { TitleBarAttribute } from "../../components/titlebar/TitleBarAttribute"
import { TitleBarView } from "../../components/titlebar/TitleBarView"
import { BaseContainerAttribute } from "./BaseContainerAttribute"

/**
 * 页面基类
 * Created by zhouL on 2025/7/14.
 */
@Component
export struct BaseContainer {
  @Link public attribute: BaseContainerAttribute
  @State public titleBarAttribute: TitleBarAttribute = this.attribute.titleBarAttribute
  @State public loadingAttribute: LoadingAttribute = this.attribute.loadingAttribute
  @State public noDataAttribute: NoDataAttribute = this.attribute.noDataAttribute
  @State public errorAttribute: ErrorAttribute = this.attribute.errorAttribute
  // 内容布局
  @BuilderParam public contentLayout?: () => void

  // 公共UI部分
  build() {
    Column() {
      TitleBarView({ attribute: this.titleBarAttribute })

      LoadingView({ attribute: this.loadingAttribute })
        .width(`100%`)
        .height(`100%`)
        .visibility(this.attribute.isShowLoading ? Visibility.Visible : Visibility.None)


      NoDataView({ attribute: this.noDataAttribute })
        .width(`100%`)
        .height(`100%`)
        .visibility(this.attribute.isShowNoData ? Visibility.Visible : Visibility.None)

      ErrorView({ attribute: this.errorAttribute })
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

