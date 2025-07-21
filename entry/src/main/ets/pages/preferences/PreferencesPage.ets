import { CoreConstants, DateUtils, PreferencesUtils, PromptUtils, ResourceUtils, StringUtils } from 'pandora'
import { Constants } from '../../config/Constants'

/**
 * Preferences测试类
 * Created by zhouL on 2025/7/20.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
struct PreferencesPage {
  @State private mLogList: Array<string> = []
  private mText: string = ""

  build() {
    Column() {

      List() {
        ForEach(this.mLogList, (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(14)
              .padding(5)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Start)

      Line()
        .width('100%')
        .height(1)
        .backgroundColor(Color.Grey)

      // 值输入框
      Row() {
        Text($r('app.string.preferences_save_title'))
          .margin({ left: 10 })

        TextInput({ placeholder: $r('app.string.preferences_input_hint'), })
          .type(InputType.Normal)
          .placeholderFont({ size: 14 })
          .margin({ left: 10, right: 10 })
          .layoutWeight(1)
          .onChange((value) => {
            this.mText = value
          })

        Button($r('app.string.preferences_clear_log'))
          .padding({ left: 10, right: 10 })
          .fontSize(14)
          .onClick(() => {
            this.mLogList = []
          })
      }
      .margin({ top: 10 })

      // 同步业务
      Row() {
        Button($r('app.string.preferences_sync_save'))
          .width(`40%`)
          .padding({ top: 10, bottom: 10 })
          .margin({ right: 10 })
          .onClick(() => {
            if (StringUtils.isEmpty(this.mText)) {
              PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
              return
            }
            PreferencesUtils.getInstance().putSync(Constants.Preferences.USER_KEY, this.mText)
            this.addLog("同步保存字符：" + this.mText)
          })
        Button($r('app.string.preferences_sync_read'))
          .width(`40%`)
          .padding({ top: 10, bottom: 10 })
          .margin({ left: 10 })
          .onClick(() => {
            const def = ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_text_def'))
            const value = PreferencesUtils.getInstance().getSync(Constants.Preferences.USER_KEY, def)
            this.addLog("同步读取字符：" + value)
          })
      }
      .margin({ top: 10 })

      // 异步业务
      Row() {
        Button($r('app.string.preferences_async_save'))
          .width(`40%`)
          .padding({ top: 10, bottom: 10 })
          .margin({ right: 10 })
          .onClick(() => {
            if (StringUtils.isEmpty(this.mText)) {
              PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
              return
            }
            PreferencesUtils.getInstance().put(Constants.Preferences.USER_KEY, this.mText)
              .then(() => {
                this.addLog("异步保存字符成功：" + this.mText)
              })
              .catch((e: Error) => {
                this.addLog("异步保存字符失败：" + e.message)
              })

          })

        Button($r('app.string.preferences_async_read'))
          .width(`40%`)
          .padding({ top: 10, bottom: 10 })
          .margin({ left: 10 })
          .onClick(() => {
            const def = ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_text_def'))
            PreferencesUtils.getInstance().get(Constants.Preferences.USER_KEY, def)
              .then((value) => {
                this.addLog("异步读取字符成功：" + value)
              })
              .catch((e: Error) => {
                this.addLog("异步读取字符失败：" + e.message)
              })


            let a = PreferencesUtils.getInstance().getAllSync()


          })
      }
      .margin({ top: 10 })

    }
    .width('100%')
    .height('100%')
  }

  private addLog(text: string) {
    this.mLogList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_1) + " : " + text)
  }
}