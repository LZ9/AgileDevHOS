/**
 * mvvm用例页面
 * Created by zhouL on 2025/7/23.
 */
@Entry
@Component
struct MvvmPage {
  //https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-mvvm
  @State isFinished: boolean = false;

  build() {
    Column() {
      // 全部待办
      TodoComponent()

      // 全选
      AllChooseComponent({isFinished: this.isFinished})

      // 待办事项1
      ThingsComponent1({isFinished: this.isFinished})

      // 待办事项2
      ThingsComponent2({isFinished: this.isFinished})
    }
    .height('100%')
    .width('100%')
    .margin({top: 5, bottom: 5})
    .backgroundColor('#90f1f3f5')
  }
}

@Component
struct TodoComponent {
  build() {
    Row() {
      Text('全部待办')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .margin({top: 10, bottom: 10})
  }
}

@Component
struct AllChooseComponent {
  @Link isFinished: boolean;

  build() {
    Row() {
      Button('全选', {type: ButtonType.Normal})
        .onClick(() => {
          this.isFinished = !this.isFinished;
        })
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#f7f6cc74')
    }
    .padding({left: 15})
    .width('100%')
    .margin({top: 10, bottom: 10})
  }
}

@Component
struct ThingsComponent1 {
  @Prop isFinished: boolean;

  build() {
    // 待办事项1
    Row({space: 15}) {
      if (this.isFinished) {
        // 此处'app.media.finished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        Image($r('sys.media.ohos_ic_public_arrow_down'))
          .width(28)
          .height(28)
      }
      else {
        // 此处'app.media.unfinished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        Image($r('sys.media.ohos_ic_public_arrow_up'))
          .width(28)
          .height(28)
      }
      Text('学习语文')
        .fontSize(24)
        .fontWeight(450)
        .decoration({type: this.isFinished ? TextDecorationType.LineThrough : TextDecorationType.None})
    }
    .height('40%')
    .width('100%')
    .border({width: 5})
    .padding({left: 15})
    .onClick(() => {
      this.isFinished = !this.isFinished;
    })
  }
}

@Component
struct ThingsComponent2 {
  @Prop isFinished: boolean;

  build() {
    // 待办事项1
    Row({space: 15}) {
      if (this.isFinished) {
        // 此处'app.media.finished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        Image($r('sys.media.ohos_ic_public_arrow_down'))
          .width(28)
          .height(28)
      }
      else {
        // 此处'app.media.unfinished'仅作示例，请开发者自行替换，否则imageSource创建失败会导致后续无法正常执行。
        Image($r('sys.media.ohos_ic_public_arrow_up'))
          .width(28)
          .height(28)
      }
      Text('学习高数')
        .fontSize(24)
        .fontWeight(450)
        .decoration({type: this.isFinished ? TextDecorationType.LineThrough : TextDecorationType.None})
    }
    .height('40%')
    .width('100%')
    .border({width: 5})
    .padding({left: 15})
    .onClick(() => {
      this.isFinished = !this.isFinished;
    })
  }
}