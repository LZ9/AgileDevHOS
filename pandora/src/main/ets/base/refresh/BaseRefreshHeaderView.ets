/**
 * 顶部刷新提示布局基础类
 * Created by zhouL on 2025/10/14.
 */
@ComponentV2
export struct BaseRefreshHeaderView {
  /** 加载图标颜色 */
  @Param lpColor: ResourceColor = Color.Grey
  /** 加载图标透明度 */
  @Param lpOpacity: number | Resource = 1
  /** 加载图标高度 */
  @Param lpHeight: Length = 32

  /** 文字内容 */
  @Param textContent: string | Resource = "正在刷新..."
  /** 文字颜色 */
  @Param textColor: ResourceColor = Color.Grey
  /** 文字大小 */
  @Param textSize: number | string | Resource = 14
  /** 文字透明度 */
  @Param textOpacity: number | Resource = 1
  /** 文字左侧间距 */
  @Param textLeftMargin: Length = 10

  /** 布局最小高度 */
  @Param layoutMinHeight: Length = 32

  build() {
    Stack() {
      Row() {
        LoadingProgress()
          .height(this.lpHeight)
          .aspectRatio(1)
          .color(this.lpColor)
          .opacity(this.lpOpacity)

        Text(this.textContent)
          .fontSize(this.textSize)
          .fontColor(this.textColor)
          .margin({ left: this.textLeftMargin })
          .opacity(this.textOpacity)
      }
      .alignItems(VerticalAlign.Center)
    }
    .align(Alignment.Center)
    .clip(true)
    // 设置最小高度约束保证自定义组件高度随刷新区域高度变化时自定义组件高度不会低于minHeight。
    .constraintSize({ minHeight: this.layoutMinHeight })
    .width("100%")
  }
}