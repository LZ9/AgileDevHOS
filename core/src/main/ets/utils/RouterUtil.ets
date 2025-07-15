import { ResourceUtils } from "./ResourceUtils"
import { router } from "@kit.ArkUI"

/**
 * 路由工具类
 * Created by Admin on 2025/7/15.
 */
export class RouterUtil {

  /**
   * 路由替换
   * @param context 上下文
   * @param path 路由路径
   * @param mode 路由模式
   * @param params 传递参数
   */
  public static replaceUrl(context: UIContext, path: Resource | string, mode?: router.RouterMode, params?: Object): Promise<void> {
    if (typeof path !== 'string') {
      path = ResourceUtils.toString(context.getHostContext(), path)
    }
    if (mode !== undefined) {
      return context.getRouter().replaceUrl({ url: path, params: params }, mode)
    }
    return context.getRouter().replaceUrl({ url: path, params: params })
  }

  /**
   * 路由跳转
   * @param context 上下文
   * @param path 路由路径
   * @param mode 路由模式
   * @param params 传递参数
   */
  public static pushUrl(context: UIContext, path: Resource | string, mode?: router.RouterMode, params?: Object): Promise<void> {
    if (typeof path !== 'string') {
      path = ResourceUtils.toString(context.getHostContext(), path)
    }
    if (mode !== undefined) {
      return context.getRouter().pushUrl({ url: path, params: params }, mode)
    }
    return context.getRouter().pushUrl({ url: path, params: params })
  }

  /**
   * 返回上一级
   * @param context 上下文
   */
  public static back(context: UIContext) {
    context.getRouter().back()
  }

  /**
   * 返回指定路径
   * @param context 上下文
   * @param path 路由路径
   * @param params 传递参数
   */
  public static backPath(context: UIContext, path: Resource | string, params?: Object) {
    if (typeof path !== 'string') {
      path = ResourceUtils.toString(context.getHostContext(), path)
    }
    context.getRouter().back({ url: path, params: params })
  }

  /**
   * 返回指定索引
   * @param context 上下文
   * @param index 路由索引
   * @param params 传递参数
   */
  public static backIndex(context: UIContext, index: number, params?: Object) {
    context.getRouter().back(index, params)
  }

  /**
   * 清空页面栈中的所有历史页面，仅保留当前页面作为栈顶页面
   * @param context 上下文
   */
  public static clear(context: UIContext) {
    context.getRouter().clear()
  }

  /**
   * 获取当前在页面栈内的页面数量
   * @param context 上下文
   */
  public static getLength(context: UIContext): string {
    return context.getRouter().getLength()
  }

  /**
   * 获取当前页面的状态信息
   * @param context 上下文
   */
  public static getState(context: UIContext): router.RouterState {
    return context.getRouter().getState()
  }

  /**
   * 通过索引值获取对应页面的状态信息
   * @param context 上下文
   * @param index 索引值
   */
  public static getStateByIndex(context: UIContext, index: number): router.RouterState | undefined {
    return context.getRouter().getStateByIndex(index)
  }

  /**
   * 通过url获取当前页面的状态信息
   * @param context 上下文
   * @param path 路由路径
   */
  public static getStateByUrl(context: UIContext, path: Resource | string): Array<router.RouterState> {
    if (typeof path !== 'string') {
      path = ResourceUtils.toString(context.getHostContext(), path)
    }
    return context.getRouter().getStateByUrl(path)
  }

  /**
   * 开启页面返回询问对话框
   * @param context 上下文
   * @param message 提示信息
   */
  public static showAlertBeforeBackPage(context: UIContext, message: Resource | string) {
    if (typeof message !== 'string') {
      message = ResourceUtils.toString(context.getHostContext(), message)
    }
    context.getRouter().showAlertBeforeBackPage({ message: message })
  }

  /**
   * 禁用页面返回询问对话框
   * @param context 上下文
   */
  public static hideAlertBeforeBackPage(context: UIContext) {
    context.getRouter().hideAlertBeforeBackPage()
  }

  /**
   * 获取发起跳转的页面往当前页传入的参数
   * @param context 上下文
   */
  public static getParams(context: UIContext): Object {
    return context.getRouter().getParams()
  }
}

