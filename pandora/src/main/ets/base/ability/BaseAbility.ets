import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'
import { PandoraConstants } from '../../config/PandoraConstants'
import { StatusBarUtils } from '../../utils/StatusBarUtils'

/**
 * Ability基类
 * Created by zhouL on 2025/7/20.
 */
export abstract class BaseAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
    this.startCreate()
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent(this.getLayoutPath(), (err) => {
      if (err.code) {
        return
      }
      StatusBarUtils.saveLastWindow(this.context)
      AppStorage.setOrCreate(PandoraConstants.Prop.BASE_VIEW_CONFIG, "")
      this.endCreate()
    })
  }

  /** 开始创建 */
  protected startCreate() {}

  /** 获取布局文件路径 */
  protected abstract getLayoutPath(): string

  /** 完成创建 */
  protected endCreate() {}
}

