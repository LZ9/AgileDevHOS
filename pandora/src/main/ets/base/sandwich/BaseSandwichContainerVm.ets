import { BaseRefreshContainerVm } from "../refresh/BaseRefreshContainerVm";

/**
 * 基类三明治容器控件ViewModel
 * Created by zhouL on 2025/10/29.
 */
@ObservedV2
export class BaseSandwichContainerVm extends BaseRefreshContainerVm {

  /** 是否显示顶部布局 */
  @Trace public isShowTop: boolean = true
  /** 是否显示底部布局 */
  @Trace public isShowBottom: boolean = true

  /** 显示顶部布局 */
  public showTopLayout(){
    this.isShowTop = true
  }

  /** 隐藏顶部布局 */
  public goneTopLayout(){
    this.isShowTop = false
  }

  /** 显示底部布局 */
  public showBottomLayout(){
    this.isShowBottom = true
  }

  /** 隐藏底部布局 */
  public goneBottomLayout(){
    this.isShowBottom = false
  }

}