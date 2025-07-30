import { ErrorViewVm } from "../../components/state/error/ErrorViewVm"
import { LoadingViewVm } from "../../components/state/loading/LoadingViewVm"
import { NoDataViewVm } from "../../components/state/nodata/NoDataViewVm"
import { TitleBarViewVm } from "../../components/titlebar/TitleBarViewVm"
import { PandoraConstants } from "../../config/PandoraConstants"
import { BaseContainerAttribute } from "./BaseContainerAttribute"

/**
 * 基类容器VM
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class BaseContainerVm {
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
  // 是否显示标题栏
  @Trace public isShowTitleBar: boolean = true
  // 是否显示加载页
  @Trace public isShowLoading: boolean = true
  // 是否显示无数据页
  @Trace public isShowNoData: boolean = false
  // 是否显示错误页
  @Trace public isShowError: boolean = false
  // 是否显示内容页
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
    const attribute = AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? undefined
    if (attribute !== undefined) {
      this.titleBarViewVm.titleVm.title = attribute.titleBarViewAttribute.titleOptions.title
      this.titleBarViewVm.titleVm.fontSize = attribute.titleBarViewAttribute.titleOptions.fontSize
      this.titleBarViewVm.titleVm.textAlign = attribute.titleBarViewAttribute.titleOptions.textAlign
      this.titleBarViewVm.titleVm.fontColor = attribute.titleBarViewAttribute.titleOptions.fontColor
      this.titleBarViewVm.titleVm.backgroundColor = attribute.titleBarViewAttribute.titleOptions.backgroundColor
      this.titleBarViewVm.backImgVm.src = attribute.titleBarViewAttribute.backImgOptions.src
      this.titleBarViewVm.backImgVm.width = attribute.titleBarViewAttribute.backImgOptions.width
      this.titleBarViewVm.backImgVm.height = attribute.titleBarViewAttribute.backImgOptions.height
      this.titleBarViewVm.backImgVm.objectFit = attribute.titleBarViewAttribute.backImgOptions.objectFit
      this.titleBarViewVm.backImgVm.visibility = attribute.titleBarViewAttribute.backImgOptions.visibility
      this.titleBarViewVm.backImgVm.onClick = attribute.titleBarViewAttribute.backImgOptions.onClick
      this.titleBarViewVm.dividingVm.color = attribute.titleBarViewAttribute.dividingOptions.color
      this.titleBarViewVm.dividingVm.visibility = attribute.titleBarViewAttribute.dividingOptions.visibility

      this.loadingViewVm.progressVm.width = attribute.loadingViewAttribute.progressOptions.width
      this.loadingViewVm.progressVm.color = attribute.loadingViewAttribute.progressOptions.color
      this.loadingViewVm.textVm.content = attribute.loadingViewAttribute.textOptions.content
      this.loadingViewVm.textVm.fontSize = attribute.loadingViewAttribute.textOptions.fontSize
      this.loadingViewVm.textVm.fontColor = attribute.loadingViewAttribute.textOptions.fontColor
      this.loadingViewVm.textVm.textAlign = attribute.loadingViewAttribute.textOptions.textAlign
      this.loadingViewVm.textVm.backgroundColor = attribute.loadingViewAttribute.textOptions.backgroundColor
      this.loadingViewVm.textVm.visibility = attribute.loadingViewAttribute.textOptions.visibility

      this.noDataViewVm.imgVm.src = attribute.noDataViewAttribute.imgOptions.src
      this.noDataViewVm.imgVm.width = attribute.noDataViewAttribute.imgOptions.width
      this.noDataViewVm.imgVm.height = attribute.noDataViewAttribute.imgOptions.height
      this.noDataViewVm.imgVm.objectFit = attribute.noDataViewAttribute.imgOptions.objectFit
      this.noDataViewVm.imgVm.visibility = attribute.noDataViewAttribute.imgOptions.visibility
      this.noDataViewVm.textVm.content = attribute.noDataViewAttribute.textOptions.content
      this.noDataViewVm.textVm.fontSize = attribute.noDataViewAttribute.textOptions.fontSize
      this.noDataViewVm.textVm.fontColor = attribute.noDataViewAttribute.textOptions.fontColor
      this.noDataViewVm.textVm.textAlign = attribute.noDataViewAttribute.textOptions.textAlign
      this.noDataViewVm.textVm.backgroundColor = attribute.noDataViewAttribute.textOptions.backgroundColor
      this.noDataViewVm.textVm.visibility = attribute.noDataViewAttribute.textOptions.visibility

      this.errorViewVm.imgVm.src = attribute.errorViewAttribute.imgOptions.src
      this.errorViewVm.imgVm.width = attribute.errorViewAttribute.imgOptions.width
      this.errorViewVm.imgVm.height = attribute.errorViewAttribute.imgOptions.height
      this.errorViewVm.imgVm.objectFit = attribute.errorViewAttribute.imgOptions.objectFit
      this.errorViewVm.imgVm.visibility = attribute.errorViewAttribute.imgOptions.visibility
      this.errorViewVm.textVm.content = attribute.errorViewAttribute.textOptions.content
      this.errorViewVm.textVm.fontSize = attribute.errorViewAttribute.textOptions.fontSize
      this.errorViewVm.textVm.fontColor = attribute.errorViewAttribute.textOptions.fontColor
      this.errorViewVm.textVm.textAlign = attribute.errorViewAttribute.textOptions.textAlign
      this.errorViewVm.textVm.backgroundColor = attribute.errorViewAttribute.textOptions.backgroundColor
      this.errorViewVm.textVm.visibility = attribute.errorViewAttribute.textOptions.visibility

      this.onReloadClick = attribute.onReloadClick
      this.isShowTitleBar = attribute.isShowTitleBar
      this.isShowLoading = attribute.isShowLoading
      this.isShowNoData = attribute.isShowNoData
      this.isShowError = attribute.isShowError
      this.isShowContent = attribute.isShowContent
    }
  }
}
