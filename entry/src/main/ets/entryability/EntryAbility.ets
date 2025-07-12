import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { PrintLog } from 'pandora'

const TAG = 'testTag';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    PrintLog.i(TAG, 'Ability onCreate');
  }

  onDestroy(): void {
    PrintLog.i(TAG, 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    PrintLog.i(TAG, 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        PrintLog.e(TAG, `Failed to load the content. Cause: ${JSON.stringify(err)}`);
        return;
      }
      PrintLog.i(TAG, 'Ability Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    PrintLog.i(TAG, 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    PrintLog.i(TAG, 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    PrintLog.i(TAG, 'Ability onBackground');
  }

  onBackPressed(): boolean {
    PrintLog.i(TAG, 'Ability click BackPressed');
    return false;
  }
}