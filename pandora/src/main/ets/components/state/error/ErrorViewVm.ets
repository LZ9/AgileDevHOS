import { BaseContainerAttribute } from "../../../base/container/BaseContainerAttribute"
import { PandoraConstants } from "../../../config/PandoraConstants"

/**
 * 加载失败控件VM
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class ErrorViewVm {
  /** 图片参数 */
  @Trace public imgVm: ImgVm = {}
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
      this.imgVm.src = attribute.errorViewAttribute.imgOptions.src
      this.imgVm.width = attribute.errorViewAttribute.imgOptions.width
      this.imgVm.height = attribute.errorViewAttribute.imgOptions.height
      this.imgVm.objectFit = attribute.errorViewAttribute.imgOptions.objectFit
      this.imgVm.visibility = attribute.errorViewAttribute.imgOptions.visibility
      this.textVm.content = attribute.errorViewAttribute.textOptions.content
      this.textVm.fontSize = attribute.errorViewAttribute.textOptions.fontSize
      this.textVm.fontColor = attribute.errorViewAttribute.textOptions.fontColor
      this.textVm.textAlign = attribute.errorViewAttribute.textOptions.textAlign
      this.textVm.backgroundColor = attribute.errorViewAttribute.textOptions.backgroundColor
      this.textVm.visibility = attribute.errorViewAttribute.textOptions.visibility
    }
  }
}

/** 图片参数 */
@ObservedV2
export class ImgVm {
  /** 图片 */
  @Trace public src ?: PixelMap | ResourceStr | DrawableDescriptor | ImageContent
  /** 宽度 */
  @Trace public width?: Length
  /** 高度 */
  @Trace public height?: Length
  /** 图片填充效果 */
  @Trace public objectFit?: ImageFit
  /** 控件显隐 */
  @Trace public visibility?: Visibility
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