/**
 * 标题栏属性
 * Created by zhouL on 2025/7/30.
 */
export class TitleBarViewAttribute {
  /** 返回按钮参数 */
  public backImgOptions: BackImgOptions = {}
  /** 标题参数 */
  public titleOptions: TitleOptions = {}
  /** 分割线参数 */
  public dividingOptions: DividingOptions = {}
  /** 点击错误页面重试监听器 */
  public onReloadClick?: (event: ClickEvent) => void
  // 是否显示标题栏
  public isShowTitleBar: boolean = true
  // 是否显示加载页
  public isShowLoading: boolean = true
  // 是否显示无数据页
  public isShowNoData: boolean = false
  // 是否显示错误页
  public isShowError: boolean = false
  // 是否显示内容页
  public isShowContent: boolean = false
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