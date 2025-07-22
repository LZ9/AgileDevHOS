import { StringUtils } from "./StringUtils"

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
  public static toString(context: Context | undefined | null, res: string | Resource): string {
    if (context !== undefined && context !== null) {
      if (typeof res === 'string') {
        return res
      }
      return context.resourceManager.getStringSync(res)
    }
    return "null"
  }

  /**
   * 颜色转字符串
   * @param colorInt 颜色转字符串
   */
  public static colorIntToString(colorInt: number): string {
    const rgb = colorInt & 0xFFFFFF
    return '#' + rgb.toString(16).padStart(6, '0').toUpperCase()
  }

  /**
   * 颜色转字符串
   * @param context 上下文
   * @param resColor 颜色
   */
  public static toColorString(context: Context | undefined | null, resColor: ResourceColor): string {
    if (context !== undefined && context !== null) {
      if (typeof resColor === 'string') {
        return resColor
      }
      if (typeof resColor === 'number') {
        return ResourceUtils.colorIntToString(resColor)
      }
      return ResourceUtils.colorIntToString(context.resourceManager.getColorSync(resColor.id))
    }
    return "#ffffff"
  }

  /**
   * 获取rawfile目录下的文件内容（Uint8Array）
   * @param context 上下文
   * @param path 路径
   */
  public static getRawFileContentSync(context: Context | undefined | null, path: string): Uint8Array {
    if (context !== undefined && context !== null) {
      return context.resourceManager.getRawFileContentSync(path)
    }
    return new Uint8Array()
  }

  /**
   * 获取rawfile目录下的文件内容（string）
   * @param context 上下文
   * @param path 路径
   */
  public static getRawFileContentStrSync(context: Context | undefined | null, path: string): string {
    if (context !== undefined && context !== null) {
      return StringUtils.unit8ArrayToStr(ResourceUtils.getRawFileContentSync(context, path))
    }
    return "null"
  }
}

