import { FileUtils, StringUtils } from "@lodz/pandora"

/**
 * 文件目录管理器
 * Created by zhouL on 2025/8/11.
 */
export class FileManager {
  /** 单例对象 */
  private static instance: FileManager | null = null

  private constructor() {
  }

  /** 获取单例 */
  public static getInstance(): FileManager {
    if (!FileManager.instance) {
      FileManager.instance = new FileManager()
    }
    return FileManager.instance
  }

  /** 应用名称 */
  private static readonly ROOT_FOLDER_NAME: string = "AgileDevHOS"
  /** app主文件夹路径 */
  private appFolderPath = ""
  /** 缓存路径 */
  private cacheFolderPath = ""
  /** 下载路径 */
  private downloadFolderPath = ""
  /** 内容路径 */
  private contentFolderPath = ""
  /** 崩溃日志路径 */
  private crashFolderPath = ""
  /** 文件目录是否初始化 */
  private isPathInit = false

  public init(context: Context) {
    this.initPath(context)
    if (this.isPathInit) {
      this.initFolder()
    }
  }

  /** 初始化路径 */
  private initPath(context: Context) {
    let rootDir = context.filesDir //通常是：/data/storage/el2/base/haps/entry/files
    if (StringUtils.isEmpty(rootDir)) {
      this.isPathInit = false
      return
    }
    if (!rootDir.endsWith(`/`)) {
      rootDir = rootDir + `/`
    }
    this.appFolderPath = rootDir + FileManager.ROOT_FOLDER_NAME + `/` // 主文件夹路径
    this.cacheFolderPath = this.appFolderPath + "Cache" + `/` // 缓存路径
    this.downloadFolderPath = this.appFolderPath + "Download" + `/` // 下载路径
    this.contentFolderPath = this.appFolderPath + "Content" + `/` // 内容路径
    this.crashFolderPath = this.appFolderPath + "Crash" + `/` // 崩溃日志路径
    this.isPathInit = true
  }

  /** 初始化文件夹 */
  private initFolder() {
    FileUtils.createFolder(this.appFolderPath)
    FileUtils.createFolder(this.cacheFolderPath)
    FileUtils.createFolder(this.downloadFolderPath)
    FileUtils.createFolder(this.contentFolderPath)
    FileUtils.createFolder(this.crashFolderPath)
  }

  /** 获取app主文件夹路径 */
  public getAppFolderPath(): string {
    return this.fixPath(this.appFolderPath)
  }

  /** 获取缓存路径 */
  public getCacheFolderPath(): string {
    return this.fixPath(this.cacheFolderPath)
  }

  /** 获取下载路径 */
  public getDownloadFolderPath(): string {
    return this.fixPath(this.downloadFolderPath)
  }

  /** 获取内容路径 */
  public getContentFolderPath(): string {
    return this.fixPath(this.contentFolderPath)
  }

  /** 获取崩溃日志路径 */
  public getCrashFolderPath(): string {
    return this.fixPath(this.crashFolderPath)
  }

  /**
   * 修复文件夹路径
   * @param path 路径
   */
  private fixPath(path: string): string {
    if (StringUtils.isEmpty(path)) {
      throw new Error(`未初始化文件目录路径，请调用FileManager.getInstance().init(context)`)
    }
    if (this.isPathInit && !FileUtils.isExists(path)) {
      //存储可用 && 路径下的文件夹不存在，说明可能是app运行时用户删除了文件夹
      this.initFolder()
    }
    return path
  }
}
