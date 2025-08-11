import { BaseAbility, PreferencesUtils, ResourceUtils } from '@lodz/pandora'
import { BaseContainerScopeConfig } from '@lodz/pandora/src/main/ets/base/container/BaseContainerScopeConfig'
import { Constants } from '../../config/Constants'
import { FileManager } from '../../tools/FileManager'

export default class EntryAbility extends BaseAbility {
  protected startCreate(): void {
    PreferencesUtils.getInstance().init(this.context)
    PreferencesUtils.getInstance().put(Constants.Preferences.GITHUB_KEY, "https://github.com/LZ9/AgileDevHOS")
    FileManager.getInstance().init(this.context)
  }

  protected getLayoutPath(): string {
    return ResourceUtils.toString(this.context, $r('app.string.splash_page_path'))
  }

  protected createBaseContainerScopeConfig(): BaseContainerScopeConfig | undefined {
    const config: BaseContainerScopeConfig = new BaseContainerScopeConfig()
    config.titleBarTitleOptions.backgroundColor = $r('app.color.color_00A0E9')
    return config
  }
}