import { fileIo } from "@kit.CoreFileKit";

/**
 * 文件工具类
 * Created by zhouL on 2025/8/11.
 */
export class FileUtils {

  /**
   * 创建文件夹
   * @param path 路径
   */
  public static createFolder(path: string) {
    if (FileUtils.isExists(path)) {
      return
    }
    fileIo.mkdirSync(path)
  }

  /**
   * 判断文件或目录是否存在
   * @param path 路径
   */
  public static isExists(path: string): boolean {
    return fileIo.accessSync(path)
  }
}