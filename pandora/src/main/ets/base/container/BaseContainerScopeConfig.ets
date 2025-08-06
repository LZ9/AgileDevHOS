/**
 * 基类容器属性全局配置
 * Created by zhouL on 2025/7/30.
 */
export class BaseContainerScopeConfig {
  /** 标题栏返回按钮参数 */
  public titleBarBackImgOptions: TitleBarBackImgOptions = {}
  /** 标题栏标题参数 */
  public titleBarTitleOptions: TitleBarTitleOptions = {}
  /** 标题栏分割线参数 */
  public titleBarDividingOptions: TitleBarDividingOptions = {}
  /** 加载进度条参数 */
  public loadingProgressOptions: LoadingProgressOptions = {}
  /** 加载文字参数 */
  public loadingTextOptions: LoadingTextOptions = {}
  /** 无数据页图片参数 */
  public noDataImgOptions: NoDataImgOptions = {}
  /** 无数据页文字参数 */
  public noDataTextOptions: NoDataTextOptions = {}
  /** 错误页图片参数 */
  public errorImgOptions: ErrorImgOptions = {}
  /** 错误页文字参数 */
  public errorTextOptions: ErrorTextOptions = {}
}

/** 标题栏返回按钮参数 */
export interface TitleBarBackImgOptions {
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
}

/** 标题栏标题参数 */
export interface TitleBarTitleOptions {
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

/** 标题栏分割线参数 */
export interface TitleBarDividingOptions {
  /** 分割线颜色 */
  color?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}

/** 加载进度条参数 */
export interface LoadingProgressOptions {
  /** 宽度 */
  width?: Length
  /** 颜色 */
  color?: ResourceColor
}

/** 加载文字参数 */
export interface LoadingTextOptions {
  /** 文字 */
  content?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 文字位置 */
  textAlign?: TextAlign
  /** 背景色 */
  backgroundColor?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}

/** 无数据页图片参数 */
export interface NoDataImgOptions {
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
}

/** 无数据页文字参数 */
export interface NoDataTextOptions {
  /** 文字 */
  content?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 文字位置 */
  textAlign?: TextAlign
  /** 背景色 */
  backgroundColor?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}

/** 错误页图片参数 */
export interface ErrorImgOptions {
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
}

/** 错误页文字参数 */
export interface ErrorTextOptions {
  /** 文字 */
  content?: string | Resource
  /** 字体大小 */
  fontSize?: number | string | Resource
  /** 文字颜色 */
  fontColor?: ResourceColor
  /** 文字位置 */
  textAlign?: TextAlign
  /** 背景色 */
  backgroundColor?: ResourceColor
  /** 控件显隐 */
  visibility?: Visibility
}