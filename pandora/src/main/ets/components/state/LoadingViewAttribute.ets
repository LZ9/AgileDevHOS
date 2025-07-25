import { BaseContainerAttribute } from "../../base/container/BaseContainerAttribute"
import { PandoraConstants } from "../../config/PandoraConstants"

/**
 * 加载控件属性
 * Created by zhouL on 2025/7/24.
 */
export class LoadingViewAttribute {
  /** 进度条参数 */
  public progressOptions: ProgressOptions = {}
  /** 文字参数 */
  public textOptions: TextOptions = {}

  /** 隐藏提示语 */
  public goneTips() {
    this.textOptions.visibility = Visibility.None
  }

  /** 获取全局属性配置 */
  public getScopeConfig(): LoadingViewAttribute | undefined {
    return AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG)?.loadingAttribute
  }
}

/** 进度条参数 */
export interface ProgressOptions {
  /** 宽度 */
  width?: Length
  /** 颜色 */
  color?: ResourceColor | LinearGradient
  /** 描边宽度 */
  strokeWidth?: Length
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