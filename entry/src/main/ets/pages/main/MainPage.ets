import { BasePage } from 'pandora'

/**
 *
 * Created by Admin on 2025/7/14.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
struct MainPage {
  // 定义子组件专属的构建函数
  @Builder
  customContent() {
    Text('子页面内容')
      .fontSize(20)
  }

  build() {
    Column() {
      BasePage({
        builderPage: this.customContent
      })
    }
  }
}