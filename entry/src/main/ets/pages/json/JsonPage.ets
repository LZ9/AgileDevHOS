import { BaseContainer, BaseContainerAttribute, PromptUtils, RouterUtils } from 'pandora'

/**
 * Json转换测试
 * Created by zhouL on 2025/7/19.
 */
@Entry
@Component
struct JsonPage {
  @State attribute: BaseContainerAttribute = new BaseContainerAttribute()

  aboutToAppear(): void {
    const scope = this.attribute.getScopeConfig()
    if (scope !== undefined){
      this.attribute = scope
    }
    this.attribute.titleBarAttribute.backImgOptions.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.attribute.titleBarAttribute.titleOptions.title = $r('app.string.json_title')
  }

  onDidBuild(): void {
    this.attribute.showStatusCompleted()
  }

  build() {
    Stack() {
      BaseContainer({
        attribute: this.attribute,
        contentLayout: this.contentLayout
      })

    }
  }

  @Builder
  contentLayout() {
    Text($r('app.string.main_change_mood'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.Black)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })
      .onClick(() => {
        PromptUtils.toastShort(this.getUIContext(), "刷新")
      })
  }
}