import { BaseContainerAttribute } from "../../base/container/BaseContainerAttribute"
import { PandoraConstants } from "../../config/PandoraConstants"

/**
 * 无数据控件属性
 * Created by zhouL on 2025/7/24.
 */
export class NoDataViewAttribute {
  /** 图片参数 */
  public imgOptions: ImgOptions = {}
  /** 文字参数 */
  public textOptions: TextOptions = {}

  /** 隐藏提示语 */
  public goneTips() {
    this.textOptions.visibility = Visibility.None
  }

  /** 获取全局属性配置 */
  public getScopeConfig(): NoDataViewAttribute | undefined {
    return AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG)?.noDataAttribute
  }
}

/** 图片参数 */
export interface ImgOptions {
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

/** 文字参数 */
export interface TextOptions {
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