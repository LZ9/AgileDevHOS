import { ErrorAttribute } from "../../components/state/ErrorAttribute"
import { LoadingAttribute } from "../../components/state/LoadingAttribute"
import { NoDataAttribute } from "../../components/state/NoDataAttribute"
import { TitleBarAttribute } from "../../components/titlebar/TitleBarAttribute"

/**
 * 页面基类属性
 * Created by zhouL on 2025/7/24.
 */
export class BaseContainerAttribute {

  public titleBarAttribute: TitleBarAttribute = new TitleBarAttribute()
  public loadingAttribute: LoadingAttribute = new LoadingAttribute()
  public noDataAttribute: NoDataAttribute = new NoDataAttribute()
  public errorAttribute: ErrorAttribute = new ErrorAttribute()

  /** 点击错误页面重试监听器 */
  public onReloadClick?: (event: ClickEvent) => void

  // 是否显示加载页
  public isShowLoading: boolean = true
  // 是否显示无数据页
  public isShowNoData: boolean = false
  // 是否显示错误页
  public isShowError: boolean = false
  // 是否显示内容页
  public isShowContent: boolean = false

  public showStatusLoading() {
    this.isShowLoading = true
    this.isShowNoData = false
    this.isShowError = false
    this.isShowContent = false
  }

  public showStatusNoData() {
    this.isShowLoading = false
    this.isShowNoData = true
    this.isShowError = false
    this.isShowContent = false
  }

  public showStatusError() {
    this.isShowLoading = false
    this.isShowNoData = false
    this.isShowError = true
    this.isShowContent = false
  }

  public showStatusCompleted() {
    this.isShowLoading = false
    this.isShowNoData = false
    this.isShowError = false
    this.isShowContent = true
  }
}
