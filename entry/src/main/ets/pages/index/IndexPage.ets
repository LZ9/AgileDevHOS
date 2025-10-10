import { HMDefaultGlobalAnimator, HMNavigation } from "@hadss/hmrouter"
import { AttributeUpdater } from "@kit.ArkUI"

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
        homePageUrl: 'SplashPage',
        options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
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