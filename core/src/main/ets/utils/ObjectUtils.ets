/**
 * 对象工具类
 * Created by zhouL on 2025/8/11.
 */
export class ObjectUtils {

  /**
   * 合并对象
   * @param target 目标
   * @param source 来源
   */
  public static  assign(target: Record<string, Object>, ...source: Object[]): Record<string, Object> {
    for (const items of source) {
      for (const key of Object.keys(items)) {
        target[key] = Reflect.get(items, key)
      }
    }
    return target
  }
}