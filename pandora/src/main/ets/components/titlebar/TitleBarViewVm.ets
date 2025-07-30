import { BaseContainerAttribute } from "../../base/container/BaseContainerAttribute"
import { PandoraConstants } from "../../config/PandoraConstants"

/**
 * 标题栏控件VM
 * Created by zhouL on 2025/7/24.
 */
@ObservedV2
export class TitleBarViewVm {
  /** 返回按钮参数 */
  @Trace public backImgVm: BackImgVm = {}
  /** 标题参数 */
  @Trace public titleVm: TitleVm = {}
  /** 分割线参数 */
  @Trace public dividingVm: DividingVm = {}

  /** 隐藏返回按钮 */
  public goneBackImg() {
    this.backImgVm.visibility = Visibility.Hidden
  }

  /** 显示分割线 */
  public showDividingLine() {
    this.dividingVm.visibility = Visibility.Visible
  }

  /** 获取并设置全局属性配置 */
  public setScopeConfig() {
    const attribute = AppStorage.get<BaseContainerAttribute>(PandoraConstants.Storage.BASE_VIEW_CONFIG) ?? undefined
    if (attribute !== undefined) {
      this.titleVm.title = attribute.titleBarViewAttribute.titleOptions.title
      this.titleVm.fontSize = attribute.titleBarViewAttribute.titleOptions.fontSize
      this.titleVm.textAlign = attribute.titleBarViewAttribute.titleOptions.textAlign
      this.titleVm.fontColor = attribute.titleBarViewAttribute.titleOptions.fontColor
      this.titleVm.backgroundColor = attribute.titleBarViewAttribute.titleOptions.backgroundColor
      this.backImgVm.src = attribute.titleBarViewAttribute.backImgOptions.src
      this.backImgVm.width = attribute.titleBarViewAttribute.backImgOptions.width
      this.backImgVm.height = attribute.titleBarViewAttribute.backImgOptions.height
      this.backImgVm.objectFit = attribute.titleBarViewAttribute.backImgOptions.objectFit
      this.backImgVm.visibility = attribute.titleBarViewAttribute.backImgOptions.visibility
      this.backImgVm.onClick = attribute.titleBarViewAttribute.backImgOptions.onClick
      this.dividingVm.color = attribute.titleBarViewAttribute.dividingOptions.color
      this.dividingVm.visibility = attribute.titleBarViewAttribute.dividingOptions.visibility
    }
  }
}

/** 返回按钮参数 */
@ObservedV2
export class BackImgVm {
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
  /** 点击监听器 */
  @Trace public onClick?: (event: ClickEvent) => void
}

/** 标题参数 */
@ObservedV2
export class TitleVm {
  /** 标题文字 */
  @Trace public title?: string | Resource
  /** 字体大小 */
  @Trace public fontSize?: number | string | Resource
  /** 文字位置 */
  @Trace public textAlign?: TextAlign
  /** 文字颜色 */
  @Trace public fontColor?: ResourceColor
  /** 标题栏背景色 */
  @Trace public backgroundColor?: ResourceColor
}

/** 分割线参数 */
@ObservedV2
export class DividingVm {
  /** 分割线颜色 */
  @Trace public color?: ResourceColor
  /** 控件显隐 */
  @Trace public visibility?: Visibility
}