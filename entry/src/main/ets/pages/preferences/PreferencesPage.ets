import { PreferencesUtils, PromptUtils, ResourceUtils, StringUtils } from 'pandora'
import { Constants } from '../../config/Constants'

/**
 * Preferences测试类
 * Created by zhouL on 2025/7/20.
 */
@Entry
@Component
struct PreferencesPage {
  private mText: string = ""

  build() {
    Column() {
      TextInput({ placeholder: $r('app.string.preferences_input_hint'), })
        .type(InputType.Normal)
        .width('100%')
        .height(200)
        .onChange((value) => {
          this.mText = value
        })
      Row() {
        Button($r('app.string.preferences_save'))
          .width('50%')
          .height(60)
          .onClick(() => {
            if (StringUtils.isEmpty(this.mText)) {
              PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
              return
            }
            PreferencesUtils.getInstance().put(Constants.Preferences.USER_INPUT, this.mText)
              .then(() => {
                PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_save_success'))
              })
              .catch((e: Error) => {
                const tips = ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_save_fail'))
                PromptUtils.toastShort(this.getUIContext(), tips + " : " + e.message)
              })

          })
        Button($r('app.string.preferences_read'))
          .width('50%')
          .height(60)
          .onClick(() => {
            const value = PreferencesUtils.getInstance().getSync(
              Constants.Preferences.USER_INPUT,
              ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_text_def'))
            )
            PromptUtils.toastShort(this.getUIContext(), value)
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}