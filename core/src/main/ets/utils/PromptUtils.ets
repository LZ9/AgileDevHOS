import { PromptAction, promptAction } from "@kit.ArkUI";
import { CoreConstants } from "../config/CoreConstants";

/**
 * 提示工具类
 * Created by zhouL on 2025/7/15.
 */
export class PromptUtils {

  /**
   * 获取提示工具
   * @param context 上下文
   */
  public static getPrompt(context: UIContext): PromptAction {
    return context.getPromptAction()
  }

  /**
   * 显示提示
   * @param context 上下文
   * @param options 提示参数
   */
  public static toastOpt(context: UIContext, options: promptAction.ShowToastOptions) {
    context.getPromptAction().showToast(options)
  }

  /**
   * 显示提示并通过Promise返回其id
   * @param context 上下文
   * @param options 提示参数
   */
  public static openToast(context: UIContext, options: promptAction.ShowToastOptions): Promise<number> {
    return context.getPromptAction().openToast(options)
  }

  /**
   * 通过id编号关闭文本提示框
   * @param context 上下文
   * @param toastId 编号
   */
  public static closeToast(context: UIContext, toastId: number) {
    context.getPromptAction().closeToast(toastId)
  }

  /**
   *
   * @param context 上下文
   * @param msg 提示信息
   * @param duration 提示时长
   */
  public static toast(context: UIContext, msg: string | Resource, duration?: number) {
    PromptUtils.toastOpt(context, { message: msg, duration: duration })
  }

  /**
   * 显示短时长提示
   * @param context 上下文
   * @param message 提示信息
   */
  public static toastShort(context: UIContext, msg: string | Resource) {
    PromptUtils.toast(context, msg, CoreConstants.Prompt.Duration.SHORT)
  }

  /**
   * 显示长时长提示
   * @param context 上下文
   * @param message 提示信息
   */
  public static toastLong(context: UIContext, msg: string | Resource) {
    PromptUtils.toast(context, msg, CoreConstants.Prompt.Duration.LONG)
  }

  /**
   * 显示提示框
   * @param context 上下文
   * @param options 提示框参数
   */
  public static dialogOpt(context: UIContext, options: promptAction.ShowDialogOptions): Promise<promptAction.ShowDialogSuccessResponse> {
    return context.getPromptAction().showDialog(options)
  }

  /**
   * 显示提示框
   * @param context 上下文
   * @param title 标题
   * @param content 提示内容
   * @param buttons 按钮数组
   */
  public static dialog(context: UIContext, title: string | Resource, content: string | Resource, buttons: Array<promptAction.Button>): Promise<promptAction.ShowDialogSuccessResponse> {
    return PromptUtils.dialogOpt(context, { title: title, message: content, buttons: buttons })
  }

  /**
   * 显示操作菜单
   * @param context 上下文
   * @param options 菜单参数
   */
  public static menuOpt(context: UIContext, options: promptAction.ActionMenuOptions): Promise<promptAction.ShowDialogSuccessResponse> {
    return context.getPromptAction().showActionMenu(options)
  }

  /**
   * 显示操作菜单
   * @param context 上下文
   * @param title 标题
   * @param buttons 按钮数组
   */
  public static menu(context: UIContext, buttons: CoreConstants.Prompt.MenuBtn, title?: string | Resource): Promise<promptAction.ShowDialogSuccessResponse> {
    return PromptUtils.menuOpt(context, { title: title, buttons: buttons })
  }

}