import { CoreConstants } from '@lodz/pandora'
import { TodoBean } from '../../bean/mvvm/TodoBean'

/**
 * 代办列表项控件.
 * Created by zhouL on 2025/7/30.
 */
@ComponentV2
export struct TodoItemView {
  @Event todoBean: TodoBean

  build() {
    Row() {
      Image(this.todoBean.isFinish ? $r('sys.media.ohos_ic_public_arrow_right') : $r('sys.media.ohos_ic_public_arrow_down'))
        .width(28)
        .height(28)
        .onClick(() => {
          this.todoBean.isFinish = !this.todoBean.isFinish
        })
      Text(this.todoBean.title)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontSize(20)
        .textAlign(TextAlign.Start)
        .padding(10)
        .onClick(() => {

        })
    }
  }
}