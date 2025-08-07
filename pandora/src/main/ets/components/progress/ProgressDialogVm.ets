/**
 * 加载框ViewModel
 * Created by zhouL on 2025/8/7.
 */
@Observed
export class ProgressDialogVm {
  /** 进度条参数 */
  @Track public progressVm: LoadingProgressVm = {}
  /** 文字参数 */
  @Track public textVm: TextVm = {}
  /** 最小宽度 */
  @Track public minWidth?: Length
  /** 最小高度 */
  @Track public minHeight?: Length
  /** 背景颜色 */
  @Track public backgroundColor?: ResourceColor
  /** 圆角 */
  @Track public borderRadius?: Length | BorderRadiuses | LocalizedBorderRadiuses
  /** 圆角 */
  @Track public padding?: Padding | Length | LocalizedPadding
}

/** 进度条参数 */
@Observed
export class LoadingProgressVm {
  /** 宽度 */
  @Track public width?: Length
  /** 高度 */
  @Track public height?: Length
  /** 颜色 */
  @Track public color?: ResourceColor
}

/** 文字参数 */
@Observed
export class TextVm {
  /** 文字 */
  @Track public content?: string | Resource
  /** 字体大小 */
  @Track public fontSize?: number | string | Resource
  /** 文字颜色 */
  @Track public fontColor?: ResourceColor
  /** 控件显隐 */
  @Track public visibility?: Visibility
}