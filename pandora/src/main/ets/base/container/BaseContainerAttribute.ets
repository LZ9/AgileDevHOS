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
  public titleBarAttribute: TitleBarViewAttribute = new TitleBarViewAttribute()
  /** 加载页属性 */
  public loadingAttribute: LoadingViewAttribute = new LoadingViewAttribute()
  /** 无数据页属性 */
  public noDataAttribute: NoDataViewAttribute = new NoDataViewAttribute()
  /** 错误页属性 */
  public errorAttribute: ErrorViewAttribute = new ErrorViewAttribute()
  /** 点击错误页面重试监听器 */
  public onReloadClick?: (event: ClickEvent) => void
  // 是否显示标题栏
  public isShowTitleBar: boolean = true
  // 是否显示加载页
  public isShowLoading: boolean = true
  // 是否显示无数据页
  public isShowNoData: boolean = false
  // 是否显示错误页
  public isShowError: boolean = false
  // 是否显示内容页
  public isShowContent: boolean = false

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

  /** 获取全局属性配置 */
  public getScopeConfig(): BaseContainerAttribute | undefined {
    return AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG)
  }
}
