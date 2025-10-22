import { HMRouter, HMRouterMgr } from "@hadss/hmrouter";
import {
  BaseLoadMoreFooterView,
  BaseRefreshContainer,
  BaseRefreshContainerVm,
  BaseRefreshHeaderView,
  DataError,
  Disposable,
  LoadMoreAgent,
  Observer,
  PrintLog,
  PromiseAgent,
  PromptUtils,
} from "@lodz/pandora";
import { ApiManager } from "../../api/ApiManager";
import { ActivityListBean } from "../../bean/api/ActivityListBean";
import { ActivityListItemBean } from "../../bean/api/ActivityListItemBean";
import { ResponseData } from "../../bean/api/ResponseData";
import { Constants } from "../../config/Constants";
import { RouterGuide } from "../../config/RouterGuide";

/**
 * 刷新/加载更多测试类
 * Created by zhouL on 2025/10/13.
 */
@ComponentV2
@HMRouter({ pageUrl: RouterGuide.RefreshLoadPage })
export struct RefreshLoadPage {
  @Local vm: BaseRefreshContainerVm = new BaseRefreshContainerVm()
  /** 活动列表 */
  @Local list: Array<ActivityListItemBean> = []
  /** 加载更多状态 */
  @Local loadingStatus: number = LoadMoreAgent.LOAD_STATUS_READY
  /** 下拉偏移量 */
  @Local pullDownOffset: number = 0
  /** 加载更多代理 */
  @Local loadMoreAgent: LoadMoreAgent = new LoadMoreAgent()
  /** 接口任务 */
  private disposable?: Disposable

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.titleVm.title = HMRouterMgr.getCurrentParam() as string
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      HMRouterMgr.pop()
    }

    this.vm.onReloadClick = () => {
      this.vm.showStatusLoading()
      this.requestFirstData()
    }

    // 监听下拉偏移量变化
    this.vm.onOffsetChange = (offset: number) => {
      this.pullDownOffset = offset
    }

    // 刷新回调
    this.vm.onRefreshing = () => {
      PrintLog.d(Constants.Log.TAG, `下拉刷新`)
      this.disposable?.dispose()
      this.requestFirstData()
    }

    this.loadMoreAgent.setOnLoadingStatusChangeListener((status) => {
      PrintLog.d(Constants.Log.TAG, `加载状态 : ${status}`)
      this.loadingStatus = status
    })

    this.loadMoreAgent.setOnLoadMoreListener((nextPage, pageSize) => {
      this.requestLoadMoreData(nextPage)
    })
  }

  onDidBuild(): void {
    this.requestFirstData()
  }

  aboutToDisappear(): void {
    this.disposable?.dispose()
  }

  /** 请求首次数据 */
  private requestFirstData() {
    this.requestData(1, {
      onNext: (responseBean: ResponseData<ActivityListBean>) => {
        this.vm.finishRefresh()
        if (responseBean.value === undefined || responseBean.value === null) {
          this.vm.showStatusNoData()
          return
        }
        const list = responseBean.value.list ?? []
        if (list.length === 0) {
          this.vm.showStatusNoData()
          return
        }
        this.list = list
        this.loadMoreAgent.config(this.list.length, responseBean.value?.pageInfo?.totalRecords, responseBean.value?.pageInfo?.perPageRecords)
        this.vm.showStatusCompleted()
      },
      onError: (e: DataError<ResponseData<ActivityListBean>>) => {
        this.vm.finishRefresh()
        PromptUtils.toastShort(this.getUIContext(), e.message)
        this.vm.showStatusError()
      }
    })
  }

  /**
   * 请求加载更多数据
   * @param pageNo 页码
   */
  private requestLoadMoreData(pageNo: number) {
    this.requestData(pageNo, {
      onNext: (responseBean: ResponseData<ActivityListBean>) => {
        if (responseBean.value === undefined || responseBean.value === null) {
          this.loadMoreAgent.loadComplete()
          return
        }
        const list = responseBean.value.list ?? []
        if (list.length === 0) {
          this.loadMoreAgent.loadComplete()
          return
        }
        this.list = this.list.concat(list)
        this.loadMoreAgent.loadMoreSuccess(this.list.length)
      },
      onError: (e: DataError<ResponseData<ActivityListBean>>) => {
        PromptUtils.toastShort(this.getUIContext(), e.message)
        this.loadMoreAgent.loadMoreFail()
      }
    })
  }

  /**
   * 请求活动列表数据
   * @param pageNo 页码
   * @param observer 订阅者
   */
  private requestData(pageNo: number, observer: Observer<ResponseData<ActivityListBean>>) {
    this.disposable = PromiseAgent.create<ResponseData<ActivityListBean>>()
      .then(() => ApiManager.create().getActivityList(pageNo))
      .subscribe(observer)
  }

  /**
   * 加载更多提示文案
   * @param loadingStatus 加载状态
   */
  private getLoadMoreTips(loadingStatus: number): string  {
    if (loadingStatus === LoadMoreAgent.LOAD_STATUS_LOADING) {
      return "加载中..."
    }
    if (loadingStatus === LoadMoreAgent.LOAD_STATUS_COMPLETE) {
      return "已全部加载完成"
    }

    if (loadingStatus === LoadMoreAgent.LOAD_STATUS_FAIL) {
      return "加载失败，请点击重试"
    }
    return ""
  }

  build() {
    Stack() {
      BaseRefreshContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentLayout()
        },
        // 自定义下拉刷新组件，根据业务需求设置
        refreshHeaderLayout: () => {
          this.customRefreshComponent()
        }
      })
    }
  }

  @Builder
  contentLayout() {
    List() {
      ForEach(this.list, (item: ActivityListItemBean, index) => {
        ListItem() {
          Column() {
            Text(`${index + 1}. ${item.activityName}`)
              .width('100%')
              .height(80)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)

            Divider()
              .width("100%")
              .height(1)
              .color($r('app.color.color_757575'))
          }
        }
      })
      ListItem() {
        BaseLoadMoreFooterView({
          lpColor: $r('app.color.color_00A0E9'),
          lpVisibility: this.loadingStatus === LoadMoreAgent.LOAD_STATUS_LOADING ? Visibility.Visible : Visibility.None,
          textContent: this.getLoadMoreTips(this.loadingStatus),
          textColor: this.loadingStatus === LoadMoreAgent.LOAD_STATUS_FAIL ? $r('app.color.color_EA413C') : $r('app.color.color_00A0E9')
        })
          .visibility(this.loadingStatus === LoadMoreAgent.LOAD_STATUS_READY ? Visibility.None : Visibility.Visible)
          .onClick(() => {
            if (this.loadingStatus === LoadMoreAgent.LOAD_STATUS_FAIL) {
              this.loadMoreAgent.failReload()
            }
          })
      }
    }
    .width("100%")
    .height("100%")
    .onScrollIndex(this.loadMoreAgent.scrollIndexListener)
    .scrollBar(BarState.Off)
    // 开启边缘滑动效果。
    .edgeEffect(EdgeEffect.None)
  }

  @Builder
  customRefreshComponent() {
    BaseRefreshHeaderView({
      lpColor: $r('app.color.color_00A0E9'),
      lpOpacity: this.pullDownOffset >= this.vm.refreshOffset ? 1 : this.pullDownOffset / this.vm.refreshOffset,
      textContent: "刷新中...",
      textColor: $r('app.color.color_00A0E9'),
      textOpacity: this.pullDownOffset >= this.vm.refreshOffset ? 1 : this.pullDownOffset / this.vm.refreshOffset
    })
  }
}