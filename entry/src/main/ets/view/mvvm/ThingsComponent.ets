import ThingsViewModel from "../../vm/mvvm/ThingsViewModel";

/**
 *
 * Created by zhouL on 2025/7/29.
 */
@Component
export struct ThingsComponent {
  @Prop things: ThingsViewModel;

  @Builder
  displayIcon(icon: Resource) {
    Image(icon)
      .width(28)
      .height(28)
      .onClick(() => {
        this.things.updateIsFinish(); // View层点击事件发生时，调用ViewModel层方法updateIsFinish处理逻辑
      })
  }

  build() {
    // 待办事项
    Row({ space: 15 }) {
      if(this.things.isFinish) {
        // 此处'app.media.finished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        this.displayIcon($r('sys.media.ohos_ic_public_arrow_left'));
      } else {
        // 此处'app.media.unfinished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        this.displayIcon($r('sys.media.ohos_ic_public_arrow_right'));
      }

      Text(`${this.things.thingsName}`)
        .fontSize(24)
        .fontWeight(450)
        .decoration({ type: this.things.isFinish ? TextDecorationType.LineThrough: TextDecorationType.None })
        .onClick(() => {
          this.things.addSuffixes(); // View层点击事件发生时，调用ViewModel层方法addSuffixes处理逻辑
        })
    }
    .height('8%')
    .width('90%')
    .padding({ left: 15 })
    .opacity(this.things.isFinish ? 0.3 : 1)
    .border({ width: 1 })
    .borderColor(Color.White)
    .borderRadius(25)
    .backgroundColor(Color.White)
  }
}