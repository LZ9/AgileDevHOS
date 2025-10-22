import { LoadMoreAgent } from "../../utils/loadmore/LoadMoreAgent"

/**
 * 底部加载更多布局基础类
 * Created by zhouL on 2025/10/14.
 */
@ComponentV2
export struct BaseLoadMoreFooterView {

  /** 加载图标颜色 */
  @Param lpColor: ResourceColor = Color.Grey
  /** 加载图标高度 */
  @Param lpHeight: Length = 32
  /** 加载图标右侧间距 */
  @Param lpRightMargin: Length = 10
  /** 加载图标显隐 */
  @Param lpVisibility: Visibility = Visibility.Visible

  /** 文字内容 */
  @Param textContent: string | Resource = "正在加载..."
  /** 文字颜色 */
  @Param textColor: ResourceColor = Color.Grey
  /** 文字大小 */
  @Param textSize: number | string | Resource = 14

  /** 布局最小高度 */
  @Param layoutHeight: Length = 40

  build() {
    Row() {
      LoadingProgress()
        .height(this.lpHeight)
        .aspectRatio(1)
        .color(this.lpColor)
        .margin({ right: this.lpRightMargin })
        .visibility(this.lpVisibility)

      Text(this.textContent)
        .fontSize(this.textSize)
        .fontColor(this.textColor)
    }
    .width("100%")
    .height(this.layoutHeight)
    .justifyContent(FlexAlign.Center)
  }
}