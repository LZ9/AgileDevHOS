import { ResourceUtils } from "pandora"

/**
 * 主页数据
 * Created by zhouL on 2025/7/19.
 */
export class MainBean {
  /** 标题名称 */
  private titleName: string
  /** 页面路径资源 */
  private pageRes: Resource

  constructor(titleName: string, pageRes: Resource) {
    this.titleName = titleName
    this.pageRes = pageRes
  }

  /** 获取标题名称 */
  public getTitleName(): string {
    return this.titleName
  }

  /**
   * 获取页面路径
   * @param context 上下文
   */
  public getPagePath(context: UIContext): string {
    return ResourceUtils.toString(context.getHostContext(), this.pageRes)
  }
}
