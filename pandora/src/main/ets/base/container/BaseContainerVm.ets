import { JsonUtils } from "@lodz/core_hos"
import { ErrorViewVm } from "../../components/state/ErrorViewVm"
import { LoadingViewVm } from "../../components/state/LoadingViewVm"
import { NoDataViewVm } from "../../components/state/NoDataViewVm"
import { TitleBarViewVm } from "../../components/titlebar/TitleBarViewVm"
import { PandoraConstants } from "../../config/PandoraConstants"

/**
 * 页面基类属性
 * Created by zhouL on 2025/7/24.
 */
export class BaseContainerVm {
  /** 标题栏属性 */
  @Track public titleBarViewVm: TitleBarViewVm = new TitleBarViewVm()
  /** 加载页属性 */
  @Track public loadingViewVm: LoadingViewVm = new LoadingViewVm()
  /** 无数据页属性 */
  @Track public noDataViewVm: NoDataViewVm = new NoDataViewVm()
  /** 错误页属性 */
  @Track public errorViewVm: ErrorViewVm = new ErrorViewVm()
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
    const vm = JsonUtils.jsonToBean<BaseContainerVm>(json) ?? undefined
    if (vm !== undefined) {
      this.titleBarViewVm = vm.titleBarViewVm
      this.loadingViewVm = vm.loadingViewVm
      this.noDataViewVm = vm.noDataViewVm
      this.errorViewVm = vm.errorViewVm
      this.onReloadClick = vm.onReloadClick
      this.isShowTitleBar = vm.isShowTitleBar
      this.isShowLoading = vm.isShowLoading
      this.isShowNoData = vm.isShowNoData
      this.isShowError = vm.isShowError
      this.isShowContent = vm.isShowContent
    }
  }
}
