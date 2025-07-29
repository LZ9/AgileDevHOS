import { JsonUtils } from "@lodz/core_hos"
import { ErrorViewAttribute } from "../../components/state/ErrorViewAttribute"
import { LoadingViewAttribute } from "../../components/state/LoadingViewAttribute"
import { NoDataViewAttribute } from "../../components/state/NoDataViewAttribute"
import { TitleBarViewAttribute } from "../../components/titlebar/TitleBarViewAttribute"
import { PandoraConstants } from "../../config/PandoraConstants"

/**
 * 页面基类属性
 * Created by zhouL on 2025/7/24.
 */
export class BaseContainerAttribute {
  /** 标题栏属性 */
  @Track public titleBarViewAttribute: TitleBarViewAttribute = new TitleBarViewAttribute()
  /** 加载页属性 */
  @Track public loadingViewAttribute: LoadingViewAttribute = new LoadingViewAttribute()
  /** 无数据页属性 */
  @Track public noDataViewAttribute: NoDataViewAttribute = new NoDataViewAttribute()
  /** 错误页属性 */
  @Track public errorViewAttribute: ErrorViewAttribute = new ErrorViewAttribute()
  /** 点击错误页面重试监听器 */
  @Track public onReloadClick?: (event: ClickEvent) => void
  // 是否显示标题栏
  @Track public isShowTitleBar: boolean = true
  // 是否显示加载页
  @Track public isShowLoading: boolean = true
  // 是否显示无数据页
  @Track public isShowNoData: boolean = false
  // 是否显示错误页
  @Track public isShowError: boolean = false
  // 是否显示内容页
  @Track public isShowContent: boolean = false

  /** 显示加载页面 */
  public showStatusLoading() {
    this.isShowLoading = true
    this.isShowNoData = false
    this.isShowError = false
    this.isShowContent = false
  }

  /** 显示无数据页面 */
  public showStatusNoData() {
    this.isShowLoading = false
    this.isShowNoData = true
    this.isShowError = false
    this.isShowContent = false
  }

  /** 显示错误页面 */
  public showStatusError() {
    this.isShowLoading = false
    this.isShowNoData = false
    this.isShowError = true
    this.isShowContent = false
  }

  /** 显示内容页面 */
  public showStatusCompleted() {
    this.isShowLoading = false
    this.isShowNoData = false
    this.isShowError = false
    this.isShowContent = true
  }

  /** 隐藏标题栏 */
  public goneTitleBar() {
    this.isShowTitleBar = false
  }

  /** 获取并设置全局属性配置 */
  public setScopeConfig() {
    const json = AppStorage.get<string>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? "{}"
    const attribute = JsonUtils.jsonToBean<BaseContainerAttribute>(json) ?? undefined
    if (attribute !== undefined) {
      this.titleBarViewAttribute = attribute.titleBarViewAttribute
      this.loadingViewAttribute = attribute.loadingViewAttribute
      this.noDataViewAttribute = attribute.noDataViewAttribute
      this.errorViewAttribute = attribute.errorViewAttribute
      this.onReloadClick = attribute.onReloadClick
      this.isShowTitleBar = attribute.isShowTitleBar
      this.isShowLoading = attribute.isShowLoading
      this.isShowNoData = attribute.isShowNoData
      this.isShowError = attribute.isShowError
      this.isShowContent = attribute.isShowContent
    }
  }
}
