import { Groupable, ResourceUtils } from "@lodz/pandora"

/**
 * 主页数据
 * Created by zhouL on 2025/7/19.
 */
export class MainBean implements Groupable {
  /** 标题名称 */
  private titleName: string
  /** 页面路径资源 */
  private pageRes: Resource
  /** 索引文字 */
  private indexText: string

  constructor(titleName: string, indexText: string, pageRes: Resource) {
    this.titleName = titleName
    this.indexText = indexText
    this.pageRes = pageRes
  }

  getSortStr(): string {
    return this.indexText
  }

  /** 获取标题名称 */
  public getTitleName(): string {
    return this.titleName
  }

  /** 获取索引文字 */
  public getIndexText(): string {
    return this.indexText
  }

  /**
   * 获取页面路径
   * @param context 上下文
   */
  public getPagePath(context: UIContext): string {
    return ResourceUtils.toString(context.getHostContext(), this.pageRes)
  }
}
