/**
 * 加载更多代理
 * Created by zhouL on 2025/10/14.
 */
export class LoadMoreAgent {
  /** 就绪 */
  public static readonly LOAD_STATUS_READY = 0
  /** 正在加载 */
  public static readonly LOAD_STATUS_LOADING = 1
  /** 全部加载完成 */
  public static readonly LOAD_STATUS_COMPLETE = 2
  /** 加载失败 */
  public static readonly LOAD_STATUS_FAIL = 3

  /** 加载状态 */
  private loadingStatus: number = LoadMoreAgent.LOAD_STATUS_READY
  /** 数据列表长度 */
  private listLength: number = 0
  /** 数据列表长度 */
  private total: number = 0
  /** 数据列表长度 */
  private pageSize: number = 0
  /** 页码 */
  private pageNo: number = 1
  /** 预加载偏移量，滑动到倒数第offset个item时就回调加载接口（默认值为3） */
  private offset: number = 3

  /** 加载状态变化回调 */
  private onLoadingStatusChange?: (status: number) => void
  /** 加载更多回调 */
  private onLoadMore?: (nextPage: number, pageSize: number) => void

  /** 列表滚动监听器 */
  public scrollIndexListener = (start: number, end: number, center: number) => {
    // 未初始化不做响应
    if (this.total === 0 || this.pageSize === 0) {
      return
    }

    // 当滑动达到列表末尾时进行判断
    if (end >= this.listLength - this.offset) {
      // 就绪状态判断下一步是加载更多还是全部加载完成
      if (this.loadingStatus === LoadMoreAgent.LOAD_STATUS_READY) {
        // 当前列表长度已经大于总条数时，则认为全部加载完成。
        if (this.listLength >= this.total) {
          this.loadingStatus = LoadMoreAgent.LOAD_STATUS_COMPLETE
          this.onLoadingStatusChange?.(this.loadingStatus)
          return
        }
        // 列表长度小于总条数时，则加载更多
        this.loadingStatus = LoadMoreAgent.LOAD_STATUS_LOADING
        this.pageNo++
        this.onLoadingStatusChange?.(this.loadingStatus)
        this.onLoadMore?.(this.pageNo, this.pageSize)
        return
      }
    }
  }

  /**
   * 配置加载更多
   * @param listLength 当前数据列表长度
   * @param total 总条数
   * @param pageSize 每页条数
   * @param offset 预加载偏移量，滑动到倒数第offset个item时就回调加载接口（默认值为3）
   */
  public config(listLength: number, total: number | undefined, pageSize: number | undefined, offset?: number) {
    this.listLength = listLength
    if (total !== undefined && total > 0) {
      this.total = total
    }
    if (pageSize !== undefined && pageSize > 0) {
      this.pageSize = pageSize
      if (offset !== undefined && offset > 0) {
        if (offset >= pageSize) {
          this.offset = pageSize - 1
        }else {
          this.offset = offset
        }
      }
    }
    this.pageNo = 1
    this.loadingStatus = LoadMoreAgent.LOAD_STATUS_READY
    this.onLoadingStatusChange?.(this.loadingStatus)
  }

  /**
   * 设置加载状态变化监听器
   * @param listener 监听器，回调加载状态
   */
  public setOnLoadingStatusChangeListener(listener: (status: number) => void) {
    this.onLoadingStatusChange = listener
  }

  /**
   * 设置加载更多监听器
   * @param listener 监听器，回调下一页页码、每页条数
   */
  public setOnLoadMoreListener(listener: (nextPage: number, pageSize: number) => void) {
    this.onLoadMore = listener
  }

  /** 设置加载完成 */
  public loadComplete() {
    this.loadingStatus = LoadMoreAgent.LOAD_STATUS_COMPLETE
    this.onLoadingStatusChange?.(this.loadingStatus)
  }

  /**
   * 设置加载成功
   * @param listLength 加载完成后的数据列表长度
   */
   public loadMoreSuccess(listLength: number) {
    this.loadingStatus = LoadMoreAgent.LOAD_STATUS_READY
    this.listLength = listLength
     this.onLoadingStatusChange?.(this.loadingStatus)
  }

  /** 设置加载失败 */
  public loadMoreFail() {
    this.loadingStatus = LoadMoreAgent.LOAD_STATUS_FAIL
    this.onLoadingStatusChange?.(this.loadingStatus)
  }

  /** 失败重载 */
  public failReload() {
    this.loadingStatus = LoadMoreAgent.LOAD_STATUS_LOADING
    this.onLoadingStatusChange?.(this.loadingStatus)
    this.onLoadMore?.(this.pageNo, this.pageSize)
  }

  /** 获取加载状态 */
  public getLoadingStatus() {
    return this.loadingStatus
  }

}

