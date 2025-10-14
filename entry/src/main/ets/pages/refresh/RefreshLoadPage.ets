import { HMRouter, HMRouterMgr } from "@hadss/hmrouter";
import { BaseRefreshContainer, BaseRefreshContainerVm, BaseRefreshHeaderView, RandomUtils } from "@lodz/pandora";
import { RouterGuide } from "../../config/RouterGuide";

/**
 * 刷新/加载更多测试类
 * Created by zhouL on 2025/10/13.
 */
@ComponentV2
@HMRouter({ pageUrl: RouterGuide.RefreshLoadPage })
export struct RefreshLoadPage {
  @Local vm: BaseRefreshContainerVm = new BaseRefreshContainerVm()
  @Local arr: Array<number> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @Local isLoading: boolean = false
  /** 下拉偏移量 */
  @Local pullDownOffset: number = 0

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.titleVm.title = HMRouterMgr.getCurrentParam() as string
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      HMRouterMgr.pop()
    }

    // 监听下拉偏移量变化
    this.vm.onOffsetChange = (offset: number) => {
      this.pullDownOffset = offset
    }

    // 刷新回调
    this.vm.onRefreshing = () => {
      setTimeout(() => {
        this.vm.finishRefresh()
        this.arr.unshift(RandomUtils.getInt(0, 10))
      }, 2000)
    }
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
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
      ForEach(this.arr, (item: number) => {
        ListItem() {
          Text('' + item)
            .width('100%')
            .height(80)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .backgroundColor(0xFFFFFF)
        }.borderWidth(1)
      }, (item: string) => item)
      ListItem() {
        this.footer()
      }
    }
    .onScrollIndex((start: number, end: number) => {
      // 当达到列表末尾时，触发新数据加载。
      if (end >= this.arr.length - 1) {
        this.isLoading = true
        // 模拟新数据加载。
        setTimeout(() => {
          for (let i = 0; i < 10; i++) {
            this.arr.push(this.arr.length)
          }
          this.isLoading = false
        }, 700)
      }
    })
    .scrollBar(BarState.Off)
    // 开启边缘滑动效果。
    .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
  }

  @Builder
  footer() {
    Row() {
      LoadingProgress()
        .height(32)
        .width(48)
      Text("加载中")
    }.width("100%")
    .height(64)
    .justifyContent(FlexAlign.Center)
    // 当不处于加载中状态时隐藏组件。
    .visibility(this.isLoading ? Visibility.Visible : Visibility.Hidden)
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