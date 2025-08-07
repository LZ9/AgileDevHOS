/**
 * 生命周期控制器
 * Created by zhouL on 2025/8/7.
 */
export interface Disposable {

  /** 终止任务 */
  dispose(): void

  /** 任务是否终止 */
  isDisposed(): boolean

}
