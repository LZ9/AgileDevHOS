import { JsonUtils } from "@lodz/core_hos"
import { BaseContainerScopeConfig } from "../../../base/container/BaseContainerScopeConfig"
import { PandoraConstants } from "../../../config/PandoraConstants"

/**
 * 无数据控件ViewModel
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class NoDataViewVm {
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
    this.imgVm.src = config.noDataImgOptions.src
    this.imgVm.width = config.noDataImgOptions.width
    this.imgVm.height = config.noDataImgOptions.height
    this.imgVm.objectFit = config.noDataImgOptions.objectFit
    this.imgVm.visibility = config.noDataImgOptions.visibility
    this.textVm.content = config.noDataTextOptions.content
    this.textVm.fontSize = config.noDataTextOptions.fontSize
    this.textVm.fontColor = config.noDataTextOptions.fontColor
    this.textVm.textAlign = config.noDataTextOptions.textAlign
    this.textVm.backgroundColor = config.noDataTextOptions.backgroundColor
    this.textVm.visibility = config.noDataTextOptions.visibility
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