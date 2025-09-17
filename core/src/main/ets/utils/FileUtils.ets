import { fileIo, fileUri, WriteOptions } from "@kit.CoreFileKit";
import { image } from "@kit.ImageKit";
import util from "@ohos.util";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { dataSharePredicates } from "@kit.ArkData";

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

  /**
   * 图片Uri转Base64
   * @param imageUri 图片uri
   * @param quality 转换质量，默认60
   * @param format 图片格式，'image/jpeg'、'image/png'等
   */
  public static imageUriToBase64(imageUri: string, quality: number = 60, format: string = 'image/jpeg'): Promise<string> {
    const file = fileIo.openSync(imageUri, fileIo.OpenMode.READ_ONLY)
    const imageSource = image.createImageSource(file.fd)
    return imageSource.createPixelMap({ editable: true })
      .then((pixelMap) => {
        const imagePackerApi: image.ImagePacker = image.createImagePacker()
        const packOpts: image.PackingOption = { format: format, quality: quality }
        return imagePackerApi.packToData(pixelMap, packOpts)
      })
      .then((buffer) => {
        let helper = new util.Base64Helper()
        const base64 = helper.encodeToStringSync(new Uint8Array(buffer))
        fileIo.close(file.fd)
        imageSource.release()
        return base64
      })
  }

  /**
   * 图片Uri转PixelMap
   * @param context 上下文
   * @param imageUri 图片uri
   */
  public static imageUriToPixelMap(context: Context | undefined, imageUri: string): Promise<image.PixelMap> {
    const  phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context)
    const predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates()
    predicates.equalTo('uri', imageUri)
    return phAccessHelper.getAssets({ fetchColumns: [], predicates: predicates })
      .then((fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset>) => {
        return fetchResult.getFirstObject()
      })
      .then((asset: photoAccessHelper.PhotoAsset) => {
        return asset.getThumbnail()
      })
  }

  /**
   * PixelMap转Buffer
   * @param pixelMap 对象
   * @param quality 转换质量，默认100
   * @param format 图片格式，'image/jpeg'、'image/png'等
   */
  public static pixelMapToBuffer(pixelMap: image.PixelMap, quality: number = 100, format: string = 'image/jpeg'): Promise<ArrayBuffer> {
    const imagePackerApi: image.ImagePacker = image.createImagePacker()
    const packOpts: image.PackingOption = { format: format, quality: quality }
    return imagePackerApi.packToData(pixelMap, packOpts)
  }

  /**
   * 写入分布式文件
   * @param context 上下文
   * @param buffer 数据
   * @param fileName 文件名
   */
  public static writeDistributedFile(context: Context, buffer: ArrayBuffer, fileName: string): boolean {
    // 将资产写入分布式文件目录。
    const filePath: string = context.distributedFilesDir + '/' + fileName
    let isSuccess: boolean = true
    let file: fileIo.File | null = null
    try {
      file = fileIo.openSync(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
      fileIo.writeSync(file.fd, buffer)
    } catch (error) {
      isSuccess = false
    } finally {
      if (file !== null) {
        fileIo.closeSync(file.fd)
      }
      return isSuccess
    }
  }

  /**
   * 文件选择
   * @param count 选择数量
   * @param MIMEType 文件类型
   */
  public static fileSelect(count: number, MIMEType: photoAccessHelper.PhotoViewMIMETypes = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE): Promise<photoAccessHelper.PhotoSelectResult> {
    const options = new photoAccessHelper.PhotoSelectOptions()
    options.MIMEType = MIMEType
    options.maxSelectNumber = count
    return FileUtils.fileSelectOpts(options)
  }

  /**
   * 文件选择
   * @param options 参数配置
   */
  public static fileSelectOpts(options :photoAccessHelper.PhotoSelectOptions): Promise<photoAccessHelper.PhotoSelectResult> {
    return new photoAccessHelper.PhotoViewPicker().select(options)
  }

}