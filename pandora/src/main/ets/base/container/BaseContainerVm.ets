import { JsonUtils } from "@lodz/core_hos"
import { ErrorViewVm } from "../../components/state/error/ErrorViewVm"
import { LoadingViewVm } from "../../components/state/loading/LoadingViewVm"
import { NoDataViewVm } from "../../components/state/nodata/NoDataViewVm"
import { TitleBarViewVm } from "../../components/titlebar/TitleBarViewVm"
import { PandoraConstants } from "../../config/PandoraConstants"
import { NavContainerVm } from "../nav/NavContainerVm"
import { BaseContainerScopeConfig } from "./BaseContainerScopeConfig"

/**
 * 基类容器ViewModel
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class BaseContainerVm {
  /** 导航属性 */
  @Trace public navVm: NavContainerVm = new NavContainerVm()
  /** 标题栏属性 */
  @Trace public titleBarViewVm: TitleBarViewVm = new TitleBarViewVm()
  /** 加载页属性 */
  @Trace public loadingViewVm: LoadingViewVm = new LoadingViewVm()
  /** 无数据页属性 */
  @Trace public noDataViewVm: NoDataViewVm = new NoDataViewVm()
  /** 错误页属性 */
  @Trace public errorViewVm: ErrorViewVm = new ErrorViewVm()
  /** 点击错误页面重试监听器 */
  @Trace public onReloadClick?: (event: ClickEvent) => void

  /** 是否显示标题栏 */
  @Trace public isShowTitleBar: boolean = true
  /** 是否显示加载页 */
  @Trace public isShowLoading: boolean = true
  /** 是否显示无数据页 */
  @Trace public isShowNoData: boolean = false
  /** 是否显示错误页 */
  @Trace public isShowError: boolean = false
  /** 是否显示内容页 */
  @Trace public isShowContent: boolean = false

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
    const json = AppStorage.get<string>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? `{}`
    const config = JsonUtils.jsonToBean<BaseContainerScopeConfig>(json)
    if (config == null) {
      return
    }
    this.titleBarViewVm.backImgVm.src = config.titleBarBackImgOptions.src
    this.titleBarViewVm.backImgVm.width = config.titleBarBackImgOptions.width
    this.titleBarViewVm.backImgVm.height = config.titleBarBackImgOptions.height
    this.titleBarViewVm.backImgVm.objectFit = config.titleBarBackImgOptions.objectFit
    this.titleBarViewVm.backImgVm.visibility = config.titleBarBackImgOptions.visibility
    this.titleBarViewVm.titleVm.title = config.titleBarTitleOptions.title
    this.titleBarViewVm.titleVm.fontSize = config.titleBarTitleOptions.fontSize
    this.titleBarViewVm.titleVm.textAlign = config.titleBarTitleOptions.textAlign
    this.titleBarViewVm.titleVm.fontColor = config.titleBarTitleOptions.fontColor
    this.titleBarViewVm.titleVm.backgroundColor = config.titleBarTitleOptions.backgroundColor
    this.titleBarViewVm.dividingVm.color = config.titleBarDividingOptions.color
    this.titleBarViewVm.dividingVm.visibility = config.titleBarDividingOptions.visibility

    this.loadingViewVm.progressVm.width = config.loadingProgressOptions.width
    this.loadingViewVm.progressVm.color = config.loadingProgressOptions.color
    this.loadingViewVm.textVm.content = config.loadingTextOptions.content
    this.loadingViewVm.textVm.fontSize = config.loadingTextOptions.fontSize
    this.loadingViewVm.textVm.fontColor = config.loadingTextOptions.fontColor
    this.loadingViewVm.textVm.textAlign = config.loadingTextOptions.textAlign
    this.loadingViewVm.textVm.backgroundColor = config.loadingTextOptions.backgroundColor
    this.loadingViewVm.textVm.visibility = config.loadingTextOptions.visibility

    this.noDataViewVm.imgVm.src = config.noDataImgOptions.src
    this.noDataViewVm.imgVm.width = config.noDataImgOptions.width
    this.noDataViewVm.imgVm.height = config.noDataImgOptions.height
    this.noDataViewVm.imgVm.objectFit = config.noDataImgOptions.objectFit
    this.noDataViewVm.imgVm.visibility = config.noDataImgOptions.visibility
    this.noDataViewVm.textVm.content = config.noDataTextOptions.content
    this.noDataViewVm.textVm.fontSize = config.noDataTextOptions.fontSize
    this.noDataViewVm.textVm.fontColor = config.noDataTextOptions.fontColor
    this.noDataViewVm.textVm.textAlign = config.noDataTextOptions.textAlign
    this.noDataViewVm.textVm.backgroundColor = config.noDataTextOptions.backgroundColor
    this.noDataViewVm.textVm.visibility = config.noDataTextOptions.visibility

    this.errorViewVm.imgVm.src = config.errorImgOptions.src
    this.errorViewVm.imgVm.width = config.errorImgOptions.width
    this.errorViewVm.imgVm.height = config.errorImgOptions.height
    this.errorViewVm.imgVm.objectFit = config.errorImgOptions.objectFit
    this.errorViewVm.imgVm.visibility = config.errorImgOptions.visibility
    this.errorViewVm.textVm.content = config.errorTextOptions.content
    this.errorViewVm.textVm.fontSize = config.errorTextOptions.fontSize
    this.errorViewVm.textVm.fontColor = config.errorTextOptions.fontColor
    this.errorViewVm.textVm.textAlign = config.errorTextOptions.textAlign
    this.errorViewVm.textVm.backgroundColor = config.errorTextOptions.backgroundColor
    this.errorViewVm.textVm.visibility = config.errorTextOptions.visibility
  }
}
