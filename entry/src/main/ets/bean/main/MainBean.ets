import { Groupable, RandomUtils, ResourceUtils } from "@lodz/pandora"

/**
 * 主页数据
 * Created by zhouL on 2025/7/19.
 */
@ObservedV2
export class MainBean implements Groupable {
  /** 标题名称 */
  private titleName: string | Resource
  /** 页面路径 */
  private page: string
  /** 索引文字 */
  private indexText: string
  /** 编号 */
  @Trace
  public id: string = ""

  constructor(titleName: string | Resource, indexText: string, page: string) {
    this.id = RandomUtils.getUUID()
    this.titleName = titleName
    this.indexText = indexText
    this.page = page
  }

  getSortStr(): string {
    return this.indexText
  }

  /** 获取标题名称 */
  public getTitleName(context: Context | undefined): string {
    if (typeof this.titleName === "string") {
      return this.titleName
    }
    return ResourceUtils.getString(context, this.titleName)
  }

  /** 获取索引文字 */
  public getIndexText(): string {
    return this.indexText
  }

  /** 获取页面路径 */
  public getPage(): string {
    return this.page
  }
}
