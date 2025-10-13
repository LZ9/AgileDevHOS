import { HMDefaultGlobalAnimator, HMNavigation, IHMAnimator } from "@hadss/hmrouter"
import { AttributeUpdater } from "@kit.ArkUI"
import { RouterGuide } from "../../config/RouterGuide"

/**
 * 根页面
 * Created by zhouL on 2025/10/10.
 */
@Entry
@ComponentV2
struct IndexPage {
  modifier: NavModifier = new NavModifier()

  build() {
    Column() {
      HMNavigation({
        navigationId: 'mainNavigationId',
        homePageUrl: RouterGuide.SplashPage,
        options: {
          standardAnimator: PageAnimation,
          dialogAnimator: HMDefaultGlobalAnimator.DIALOG_ANIMATOR,
          modifier: this.modifier
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}

class NavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.hideNavBar(true)
  }
}

/** 默认页面跳转动画 */
export const PageAnimation: IHMAnimator.Effect = new IHMAnimator.Effect({
  direction: IHMAnimator.Direction.RIGHT_TO_LEFT,
})