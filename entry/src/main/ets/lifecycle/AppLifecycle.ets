import { HMLifecycle, HMLifecycleContext, IHMLifecycle } from "@hadss/hmrouter"
import { PromptUtils } from "@lodz/pandora"

/**
 *
 * Created by zhouL on 2025/10/10.
 */
@HMLifecycle({ lifecycleName: 'AppLifecycle' })
export class AppLifecycle implements IHMLifecycle{
  private lastTime: number = 0

  onBackPressed(ctx: HMLifecycleContext): boolean {
    let time = new Date().getTime()
    if (time - this.lastTime > 1000) {
      this.lastTime = time
      PromptUtils.toastShort(ctx.uiContext, '再次返回退出应用')
      return true
    }
    return false
  }
}