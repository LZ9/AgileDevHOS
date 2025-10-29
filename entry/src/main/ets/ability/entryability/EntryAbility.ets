import { BaseAbility, PreferencesUtils } from '@lodz/pandora'
import { BaseContainerScopeConfig } from '@lodz/pandora/src/main/ets/base/container/BaseContainerScopeConfig'
import { Constants } from '../../config/Constants'
import { FileManager } from '../../tools/FileManager'
import { AbilityConstant, Want } from '@kit.AbilityKit'
import { RcpUtils } from '../../api/RcpUtils'

export default class EntryAbility extends BaseAbility {
  protected startCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    PreferencesUtils.get().init(this.context)
    PreferencesUtils.get().put(Constants.Preferences.GITHUB_KEY, "https://github.com/LZ9/AgileDevHOS")
    FileManager.get().init(this.context)
  }

  protected getLayoutPath(): string {
    return "pages/index/IndexPage"
  }

  protected createBaseContainerScopeConfig(): BaseContainerScopeConfig | undefined {
    const config: BaseContainerScopeConfig = new BaseContainerScopeConfig()
    config.titleBarTitleOptions.backgroundColor = $r('app.color.color_00A0E9')
    return config
  }

  onBackPressed(): boolean {
    return false // 销毁Ability
  }

  onDestroy() {
    RcpUtils.get().release()
  }
}