/**
 * 页面基类
 * Created by Admin on 2025/7/14.
 */
@Component
export struct BasePage {
  // 定义插槽用于子组件注入UI逻辑
  @BuilderParam builderPage: () => void

  // 公共UI部分
  build() {
    Column() {
      Text('公共标题')
        .fontSize(30)
        .backgroundColor(Color.Red)
        .width(`100%`)
        .padding(10)

      this.builderPage()
    }
  }

  private getContext(): Context | undefined {
    return this.getUIContext().getHostContext();
  }
}

