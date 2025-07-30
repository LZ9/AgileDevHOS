import { BaseContainerAttribute } from "../../../base/container/BaseContainerAttribute"
import { PandoraConstants } from "../../../config/PandoraConstants"

/**
 * 加载控件VM
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class LoadingViewVm {
  /** 进度条参数 */
  @Trace public progressVm: LoadingProgressVm = {}
  /** 文字参数 */
  @Trace public textVm: TextVm = {}

  /** 隐藏提示语 */
  public goneTips() {
    this.textVm.visibility = Visibility.None
  }

  /** 获取并设置全局属性配置 */
  public setScopeConfig() {
    const attribute = AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? undefined
    if (attribute !== undefined) {
      this.progressVm.width = attribute.loadingViewAttribute.progressOptions.width
      this.progressVm.color = attribute.loadingViewAttribute.progressOptions.color
      this.textVm.content = attribute.loadingViewAttribute.textOptions.content
      this.textVm.fontSize = attribute.loadingViewAttribute.textOptions.fontSize
      this.textVm.fontColor = attribute.loadingViewAttribute.textOptions.fontColor
      this.textVm.textAlign = attribute.loadingViewAttribute.textOptions.textAlign
      this.textVm.backgroundColor = attribute.loadingViewAttribute.textOptions.backgroundColor
      this.textVm.visibility = attribute.loadingViewAttribute.textOptions.visibility
    }
  }
}

/** 进度条参数 */
@ObservedV2
export class LoadingProgressVm {
  /** 宽度 */
  @Trace public width?: Length
  /** 颜色 */
  @Trace public color?: ResourceColor
}

/** 文字参数 */
@ObservedV2
export class TextVm {
  /** 文字 */
  @Trace public content?: string | Resource
  /** 字体大小 */
  @Trace public fontSize?: number | string | Resource
  /** 文字颜色 */
  @Trace public fontColor?: ResourceColor
  /** 文字位置 */
  @Trace public textAlign?: TextAlign
  /** 背景色 */
  @Trace public backgroundColor?: ResourceColor
  /** 控件显隐 */
  @Trace public visibility?: Visibility
}