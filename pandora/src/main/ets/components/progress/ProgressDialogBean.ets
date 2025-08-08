import { promptAction } from "@kit.ArkUI"

/**
 * 加载框参数
 * Created by zhouL on 2025/8/8.
 */
export class ProgressDialogBean<E extends object> {
  public content: ComponentContent<E>
  public options: promptAction.BaseDialogOptions

  constructor(content: ComponentContent<E>, options: promptAction.BaseDialogOptions) {
    this.content = content
    this.options = options
  }
}