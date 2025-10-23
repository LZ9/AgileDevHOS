/**
 * 加载更多状态枚举
 * Created by zhouL on 2025/10/23.
 */
export enum LoadMoreStatus {
  /** 就绪 */
  Ready = 0,
  /** 正在加载 */
  Loading = 1,
  /** 全部加载完成 */
  Complete = 2,
  /** 加载失败 */
  Fail = 3
}