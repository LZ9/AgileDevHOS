import { BasePage } from '../base/BasePage'

@Component
@Preview({ deviceType: "phone" })
export struct MainPage {
  // 定义子组件专属的构建函数
  @Builder
  customContent() {
    Text('子页面内容')
      .fontSize(20)
  }

  build() {
    Column() {
      BasePage({
        contentLayout: this.customContent
      })
    }
  }
}
