/**
 * 标题栏控件属性
 * Created by zhouL on 2025/7/24.
 */
export class TitleBarViewAttribute {
  /** 返回按钮参数 */
  public backImgOptions: BackImgOptions = {}
  /** 标题参数 */
  public titleOptions: TitleOptions = {}
  /** 分割线参数 */
  public dividingOptions: DividingOptions = {}

  /** 隐藏返回按钮 */
  public goneBackImg() {
    this.backImgOptions.visibility = Visibility.Hidden
  }

  /** 显示分割线 */
  public showDividingLine() {
    this.dividingOptions.visibility = Visibility.Visible
  }

}

/** 返回按钮参数 */
export interface BackImgOptions {
  /** 图片 */
  src ?: PixelMap | ResourceStr | DrawableDescriptor | ImageContent
  /** 宽度 */
  width?: Length
  /** 高度 */
  height?: Length
  /** 图片填充效果 */
  objectFit?: ImageFit
  /** 控件显隐 */
  visibility?: Visibility
  /** 点击监听器 */
  onClick?: (event: ClickEvent) => void
}

/** 标题参数 */
export interface TitleOptions {
  /** 标题文字 */
  title?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字位置 */
  textAlign?: TextAlign
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 标题栏背景色 */
  backgroundColor?: ResourceColor
}

/** 分割线参数 */
export interface DividingOptions {
  /** 分割线颜色 */
  color?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}