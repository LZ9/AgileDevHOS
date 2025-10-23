import { LoadMoreStatus } from "../../utils/loadmore/LoadMoreStatus"

/**
 * 底部加载更多布局基础类
 * Created by zhouL on 2025/10/14.
 */
@ComponentV2
export struct BaseLoadMoreFooterView {
  /** 加载状态 */
  @Param public loadingStatus: LoadMoreStatus = LoadMoreStatus.Ready
  /** 加载图标颜色 */
  @Param public lpColor: ResourceColor = Color.Grey
  /** 加载图标高度 */
  @Param public lpHeight: Length = 32
  /** 加载图标右侧间距 */
  @Param public lpRightMargin: Length = 10
  /** 加载图标显隐 */
  @Param public lpVisibility?: Visibility = undefined

  /** 加载中文字内容 */
  @Param public textLoadingContent: string | Resource = "正在加载..."
  /** 文字颜色 */
  @Param public textLoadingColor: ResourceColor = Color.Grey
  /** 加载完成文字内容 */
  @Param public textCompletedContent: string | Resource = "已全部加载完成"
  /** 文字颜色 */
  @Param public textCompletedColor: ResourceColor = Color.Grey
  /** 加载失败文字内容 */
  @Param public textFailContent: string | Resource = "加载失败，请点击重试"
  /** 文字颜色 */
  @Param public textFailColor: ResourceColor = Color.Red
  /** 文字大小 */
  @Param public textSize: number | string | Resource = 14
  /** 布局最小高度 */
  @Param public layoutHeight: Length = 40

  /** 点击取消按钮回调 */
  @Param public onReloadClick?: () => void = undefined

  /** 获取提示语内容 */
  private getTips(): string | Resource {
    if (this.loadingStatus === LoadMoreStatus.Loading) {
      return this.textLoadingContent
    }
    if (this.loadingStatus === LoadMoreStatus.Complete) {
      return this.textCompletedContent
    }
    if (this.loadingStatus === LoadMoreStatus.Fail) {
      return this.textFailContent
    }
    return ""
  }

  /** 获取提示语文字颜色 */
  private getTipsColor(): ResourceColor | undefined {
    if (this.loadingStatus === LoadMoreStatus.Loading) {
      return this.textLoadingColor
    }
    if (this.loadingStatus === LoadMoreStatus.Complete) {
      return this.textCompletedColor
    }
    if (this.loadingStatus === LoadMoreStatus.Fail) {
      return this.textFailColor
    }
    return undefined
  }

  /** 获取加载控件的显隐值 */
  private getLpVisibility(): Visibility {
    if (this.lpVisibility !== undefined) {
      return this.lpVisibility
    }
    return this.loadingStatus === LoadMoreStatus.Loading ? Visibility.Visible : Visibility.None
  }

  build() {
    Row() {
      LoadingProgress()
        .height(this.lpHeight)
        .aspectRatio(1)
        .color(this.lpColor)
        .margin({ right: this.lpRightMargin })
        .visibility(this.getLpVisibility())

      Text(this.getTips())
        .fontSize(this.textSize)
        .fontColor(this.getTipsColor())
    }
    .width("100%")
    .height(this.layoutHeight)
    .justifyContent(FlexAlign.Center)
    .visibility(this.loadingStatus === LoadMoreStatus.Ready ? Visibility.None : Visibility.Visible)
    .onClick(() => {
      if (this.loadingStatus === LoadMoreStatus.Fail) {
        this.onReloadClick?.()
      }
    })
  }
}