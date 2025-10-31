import { JSON } from '@kit.ArkTS'

/**
 * Json解析工具类
 * Created by zhouL on 2025/7/25.
 */
export class JsonUtils {
  /**
   * json转对象
   * @param json json字符串
   * @param reviver 转换器
   * @param options 解析选项
   * @returns
   */
  public static jsonToBean<T>(json: string | undefined | null, reviver?: JSON.Transformer, options?: JSON.ParseOptions): T | null {
    if (json === undefined || json === null || json.length === 0) {
      return null
    }
    const bean = JSON.parse(json, reviver, options)
    return bean !== null ? bean as T : null
  }

  /**
   * 对象转json进行字段筛选
   * @param bean 对象
   * @param filter 筛选字段，例如：["msg", "code"]
   */
  public static beanToJsonFilter(bean: Object | undefined | null, filter: (number | string)[] | null): string {
    return JsonUtils.beanToJson(bean, filter)
  }

  /**
   * 对象转json进行数据转换
   * @param bean 对象
   * @param transformer 转换器
   */
  public static beanToJsonTransformer(bean: Object | undefined | null, transformer: JSON.Transformer): string {
    return JsonUtils.beanToJson(bean, undefined, transformer)
  }

  /**
   * 对象转json进行格式化
   * @param bean 对象
   * @param space 格式化空格，例如：'  '
   */
  public static beanToJsonForm(bean: Object | undefined | null, space: string | number): string {
    return JsonUtils.beanToJson(bean, undefined, undefined, space)
  }

  /**
   * 对象转json
   * @param bean 对象
   * @param filter 筛选字段，例如：["msg", "code"]
   * @param transformer 转换器
   * @param space 格式化空格，例如：'  '
   */
  public static beanToJson(bean: Object | undefined | null, filter?: (number | string)[] | null, transformer?: JSON.Transformer, space?: string | number): string {
    if (bean === null || bean === undefined) {
      return "{}"
    }
    if (filter !== undefined && filter !== null) {
      return JSON.stringify(bean, filter, space)
    }
    if (transformer !== undefined && transformer !== null) {
      return JSON.stringify(bean, transformer, space)
    }
    return JSON.stringify(bean, undefined, space)
  }

  /**
   * 判断对象是否包含某个字段名称
   * @param bean 对象
   * @param property 字段名称
   */
  public static has(bean: object | undefined | null, property: string): boolean {
    if (bean === undefined || bean === null) {
      return false
    }
    return JSON.has(bean, property)
  }

  /**
   * 删除对象的某个字段
   * @param bean 对象
   * @param property 字段名称
   */
  public static remove(bean: object | undefined | null, property: string) {
    if (bean === undefined || bean === null) {
      return
    }
    JSON.remove(bean, property)
  }

  /**
   * 是否是json字符串
   * @param str 字符串
   */
  public static isJsonStr(str: string): boolean {
    try {
      const result = JSON.parse(str)
      return result !== null && typeof result === 'object'
    } catch (e) {
      return false
    }
  }
}