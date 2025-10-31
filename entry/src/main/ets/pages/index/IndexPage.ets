import { CoreConstants, NavContainer } from '@lodz/pandora'
import { RouterGuide } from '../../config/RouterGuide'

/**
 * 根页面
 * Created by zhouL on 2025/10/10.
 */
@Entry
@ComponentV2
struct IndexPage {
  build() {
    Stack() {
      NavContainer({ pathName: RouterGuide.SplashPage })
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(CoreConstants.LayoutParams.MATCH_PARENT)
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}