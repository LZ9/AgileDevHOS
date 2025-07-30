import { ErrorViewAttribute } from "../../components/state/error/ErrorViewAttribute"
import { LoadingViewAttribute } from "../../components/state/loading/LoadingViewAttribute"
import { NoDataViewAttribute } from "../../components/state/nodata/NoDataViewAttribute"
import { TitleBarViewAttribute } from "../../components/titlebar/TitleBarViewAttribute"

/**
 * 基类容器属性
 * Created by zhouL on 2025/7/30.
 */
export class BaseContainerAttribute {
  /** 标题栏属性 */
  public titleBarViewAttribute: TitleBarViewAttribute = new TitleBarViewAttribute()
  /** 加载页属性 */
  public loadingViewAttribute: LoadingViewAttribute = new LoadingViewAttribute()
  /** 无数据页属性 */
  public noDataViewAttribute: NoDataViewAttribute = new NoDataViewAttribute()
  /** 错误页属性 */
  public errorViewAttribute: ErrorViewAttribute = new ErrorViewAttribute()
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
}