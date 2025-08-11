import { fileIo, fileUri, WriteOptions } from "@kit.CoreFileKit";

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

  /**
   * 打开文件
   * @param path 路径
   * @param mode 打开模式（默认fileIo.OpenMode.READ_ONLY）
   */
  public static openFile(path: string, mode?: number): fileIo.File {
    return fileIo.openSync(path, mode)
  }

  /**
   * 获取文件uri
   * @param path 路径
   */
  public static getUri(path: string): string {
    return fileUri.getUriFromPath(path)
  }

  /**
   * 写入文件
   * @param path 路径
   * @param mode 打开模式（默认fileIo.OpenMode.READ_ONLY）
   * @param buffer 写入数据内容
   * @param options 写入选项
   */
  public static writeFile(path: string, mode: number, buffer: ArrayBuffer | string, options?: WriteOptions) {
    let file = FileUtils.openFile(path, mode)
    fileIo.writeSync(file.fd, buffer, options)
    fileIo.closeSync(file.fd)
  }

}