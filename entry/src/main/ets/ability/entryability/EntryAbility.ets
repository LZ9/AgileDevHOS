import { BaseAbility, BaseContainerAttribute, PreferencesUtils, ResourceUtils } from 'pandora'
import { Constants } from '../../config/Constants'

export default class EntryAbility extends BaseAbility {
  protected startCreate(): void {
    PreferencesUtils.getInstance().init(this.context)
    PreferencesUtils.getInstance().put(Constants.Preferences.GITHUB_KEY, "https://github.com/LZ9/AgileDevHOS")
  }

  protected getLayoutPath(): string {
    return ResourceUtils.toString(this.context, $r('app.string.splash_page_path'))
  }

  protected configBaseContainerAttribute(): BaseContainerAttribute | undefined {
    const attribute: BaseContainerAttribute = new BaseContainerAttribute()
    attribute.titleBarAttribute.titleOptions.backgroundColor = $r('app.color.color_00a0e9')
    return attribute
  }
}