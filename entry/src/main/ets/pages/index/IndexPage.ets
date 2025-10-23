import { NavContainer } from '@lodz/pandora'
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
    }
  }
}