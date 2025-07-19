import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'
import { PreferencesUtils, PrintLog, ResourceUtils } from 'pandora'
import { Constants } from '../../config/Constants'


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
    PrintLog.i(Constants.Log.TAG, 'Ability onCreate')
    PreferencesUtils.getInstance().init(this.context)
  }

  onDestroy(): void {
    PrintLog.i(Constants.Log.TAG, 'Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    PrintLog.i(Constants.Log.TAG, 'Ability onWindowStageCreate')

    windowStage.loadContent(ResourceUtils.toString(this.context, $r('app.string.splash_page_path')), (err) => {
      if (err.code) {
        PrintLog.e(Constants.Log.TAG, `Failed to load the content. Cause: ${JSON.stringify(err)}`)
        return
      }
      PrintLog.i(Constants.Log.TAG, 'Ability Succeeded in loading the content.')
    })
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    PrintLog.i(Constants.Log.TAG, 'Ability onWindowStageDestroy')
  }

  onForeground(): void {
    // Ability has brought to foreground
    PrintLog.i(Constants.Log.TAG, 'Ability onForeground')
  }

  onBackground(): void {
    // Ability has back to background
    PrintLog.i(Constants.Log.TAG, 'Ability onBackground')
  }

  onBackPressed(): boolean {
    PrintLog.i(Constants.Log.TAG, 'Ability click BackPressed')
    return false
  }
}