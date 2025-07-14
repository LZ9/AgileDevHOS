/**
 * 资源工具类
 * Created by zhouL on 2025/7/13.
 */
export class ResourceUtils {
  /**
   * 获取字符串
   * @param context 上下文
   * @param res 资源对象
   */
  public static toString(context: Context | undefined | null, res: Resource): string {
    if (context !== undefined && context !== null) {
      return context.resourceManager.getStringSync(res);
    }
    return "null";
  }
}

