/**
 * app工具类
 * Created by Admin on 2025/7/14.
 */
export class AppUtils {
  /**
   * 获取page里的上下文
   * @param com page对象
   */
  public static getContext(com: BaseCustomComponent): Context | undefined {
    return com.getUIContext().getHostContext();
  }
}
