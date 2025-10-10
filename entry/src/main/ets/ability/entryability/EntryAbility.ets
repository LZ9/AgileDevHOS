import { BaseAbility, PreferencesUtils } from '@lodz/pandora'
import { BaseContainerScopeConfig } from '@lodz/pandora/src/main/ets/base/container/BaseContainerScopeConfig'
import { Constants } from '../../config/Constants'
import { RcpUtils } from '../../tools/api/RcpUtils'
import { FileManager } from '../../tools/FileManager'
import { AbilityConstant, Want } from '@kit.AbilityKit'
import { HMRouterMgr } from '@hadss/hmrouter'

export default class EntryAbility extends BaseAbility {
  protected startCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    PreferencesUtils.getInstance().init(this.context)
    PreferencesUtils.getInstance().put(Constants.Preferences.GITHUB_KEY, "https://github.com/LZ9/AgileDevHOS")
    FileManager.getInstance().init(this.context)
    HMRouterMgr.openLog('DEBUG')
    HMRouterMgr.init({ context: this.context })
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
    RcpUtils.getInstance().release()
  }
}