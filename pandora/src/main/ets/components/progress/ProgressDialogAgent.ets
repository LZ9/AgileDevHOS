import { ProgressDialog } from "./ProgressDialog";
import { ProgressDialogVm } from "./ProgressDialogVm";
import { ComponentContent, promptAction, UIContext } from "@kit.ArkUI";
import { ProgressDialogBean } from "./ProgressDialogBean";

/**
 * 加载框代理
 * Created by zhouL on 2025/8/7.
 */
export class ProgressDialogAgent {
  /** 加载框UI属性 */
  private vm: ProgressDialogVm = new ProgressDialogVm()
  /** 是否点击空白区域取消弹窗 */
  private autoCancel: boolean = true
  /** 遮罩层颜色 */
  private maskColor: ResourceColor = Color.Transparent
  /** 用户取消交互回调 */
  private onWillDismiss?: Callback<DismissDialogAction>

  /** 创建加载框代理 */
  public static create(): ProgressDialogAgent {
    return new ProgressDialogAgent()
  }

  private constructor() {}

  /**
   * 设置用户取消交互回调
   * @param onWillDismiss 回调函数
   */
  public setOnWillDismiss(onWillDismiss: Callback<DismissDialogAction>): ProgressDialogAgent {
    this.onWillDismiss = onWillDismiss
    return this
  }

  /**
   * 设置遮罩层颜色
   * @param maskColor 遮罩层颜色
   */
  public setMaskColor(maskColor: ResourceColor): ProgressDialogAgent {
    this.maskColor = maskColor
    return this
  }

  /**
   * 设置点击空白区域取消弹窗
   * @param autoCancel 是否点击空白区域取消弹窗
   */
  public setAutoCancel(autoCancel: boolean): ProgressDialogAgent {
    this.autoCancel = autoCancel
    return this
  }

  /**
   * 设置加载框UI属性
   * @param viewModel 模型
   */
  public setViewModel(viewModel: ProgressDialogVm): ProgressDialogAgent {
    this.vm = viewModel
    return this
  }

  /**
   * 构建加载框参数
   * @param context 上下文
   */
  public build(context: UIContext): ProgressDialogBean<ProgressDialogVm> {
    const content = new ComponentContent(context, wrapBuilder(ProgressDialog), this.vm)
    const options: promptAction.BaseDialogOptions = {
      autoCancel: this.autoCancel,
      maskColor: this.maskColor,
      onWillDismiss: this.onWillDismiss,
      // onWillDismiss: (dismissDialogAction: DismissDialogAction) => { //用户取消交互回调
      //   if (dismissDialogAction.reason == DismissReason.PRESS_BACK) { //按返回键取消
      //     dismissDialogAction.dismiss();
      //   }
      //   if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) { //点击空白区域取消
      //     dismissDialogAction.dismiss();
      //   }
      // },
      alignment: DialogAlignment.Center,
    }
    return new ProgressDialogBean<ProgressDialogVm>(content, options)
  }

  /**
   * 开打弹框
   * @param context 上下文
   */
  public open(context: UIContext): ComponentContent<ProgressDialogVm> {
    const bean = this.build(context)
    context.getPromptAction().openCustomDialog(bean.content, bean.options)
    return bean.content
  }

  /**
   * 构建自定义加载框参数
   * @param content 组件内容
   * @param options 参数
   */
  public buildCustom<E extends object>(content: ComponentContent<E>, options: promptAction.BaseDialogOptions): ProgressDialogBean<E> {
    return new ProgressDialogBean<E>(content, options)
  }

  /**
   * 显示自定义加载框
   * @param context 上下文
   * @param content 组件内容
   * @param options 参数
   */
  public openCustom<E extends object>(context: UIContext, content: ComponentContent<E>, options: promptAction.BaseDialogOptions): ComponentContent<E> {
    context.getPromptAction().openCustomDialog(content, options)
    return content
  }

  /** 关闭加载框 */
  public static close<E extends object>(context: UIContext, content: ComponentContent<E>) {
    context.getPromptAction().closeCustomDialog(content)
  }
}