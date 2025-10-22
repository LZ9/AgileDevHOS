import { LoadMoreAgent } from "../../utils/loadmore/LoadMoreAgent";
import { BaseContainerVm } from "../container/BaseContainerVm";

/**
 * 基类刷新容器ViewModel
 * Created by zhouL on 2025/10/13.
 */
@ObservedV2
export class BaseRefreshContainerVm extends BaseContainerVm {
  /** 是否正在刷新 */
  @Trace public isRefreshing: boolean = false
  /** 摩擦系数（1-100），值越大越敏感 */
  @Trace public refreshFriction?: number | string
  /** 刷新文字 */
  @Trace public refreshPromptText?: ResourceStr
  /** 自定义拖拽动画组件 */
  @Trace public refreshingContent?: ComponentContent

  /** 触发刷新的下拉偏移量高度 */
  @Trace public refreshOffset: number = 64
  /** 控件背景色 */
  @Trace public refreshBackgroundColor?: ResourceColor
  /** 是否启用下拉刷新 */
  @Trace public isEnableRefresh: boolean = true

  /** 下拉偏移量变化回调 */
  @Trace public onOffsetChange?: (offset: number) => void
  /** 下拉状态变化回调 */
  @Trace public onStateChange?: (state: RefreshStatus) => void
  /** 刷新回调 */
  @Trace public onRefreshing?: () => void

  /** 加载更多状态 */
  @Trace loadingStatus: number = LoadMoreAgent.LOAD_STATUS_READY
  /** 加载更多代理 */
  @Trace loadMoreAgent: LoadMoreAgent = new LoadMoreAgent()

  public finishRefresh(){
    this.isRefreshing = false
  }
}