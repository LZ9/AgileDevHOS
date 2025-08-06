import { JsonUtils } from "@lodz/core_hos"
import { BaseContainerScopeConfig } from "../../../base/container/BaseContainerScopeConfig"
import { PandoraConstants } from "../../../config/PandoraConstants"

/**
 * 加载失败控件ViewModel
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
    const json = AppStorage.get<string>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? `{}`
    const config = JsonUtils.jsonToBean<BaseContainerScopeConfig>(json)
    if (config == null) {
      return
    }
    this.imgVm.src = config.errorImgOptions.src
    this.imgVm.width = config.errorImgOptions.width
    this.imgVm.height = config.errorImgOptions.height
    this.imgVm.objectFit = config.errorImgOptions.objectFit
    this.imgVm.visibility = config.errorImgOptions.visibility
    this.textVm.content = config.errorTextOptions.content
    this.textVm.fontSize = config.errorTextOptions.fontSize
    this.textVm.fontColor = config.errorTextOptions.fontColor
    this.textVm.textAlign = config.errorTextOptions.textAlign
    this.textVm.backgroundColor = config.errorTextOptions.backgroundColor
    this.textVm.visibility = config.errorTextOptions.visibility
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