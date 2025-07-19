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

  public getTitleName(): string {
    return this.titleName
  }

  public getPageRes(): Resource {
    return this.pageRes
  }
}
