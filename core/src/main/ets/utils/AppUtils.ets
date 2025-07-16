/**
 * app工具类
 * Created by zhouL on 2025/7/14.
 */
export class AppUtils {
  /**
   * 获取page里的上下文
   * @param com page对象
   */
  public static getContext(com: BaseCustomComponent): Context | undefined {
    return com.getUIContext().getHostContext();
  }

  /**
   * 是否定义
   * @param obj 对象
   */
  public static isDefined(obj: object | undefined | null): boolean {
    return obj !== undefined && obj !== null;
  }
}
