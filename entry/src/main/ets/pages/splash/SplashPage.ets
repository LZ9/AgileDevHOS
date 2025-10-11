import { PermissionGrantUtils, PermissionResult, PromptUtils } from '@lodz/pandora'
import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { RouterGuide } from '../../config/RouterGuide';

/**
 * 启动页
 * Created by zhouL on 2025/7/13.
 */
@ComponentV2
@Preview({ deviceType: "phone" })
@HMRouter({ pageUrl: RouterGuide.SplashPage })
export struct SplashPage {
  build() {
    Stack() {
      Image($r(`app.media.bg_splash`))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 设置图片覆盖顶部状态栏和底部导航栏

      Text($r(`app.string.splash_title`))
        .fontSize(24)
        .fontColor(Color.White)
        .margin({ top: 100 })
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Top) // 设置内容垂直顶部对齐
  }

  aboutToAppear(): void {
    PermissionGrantUtils.auto(this.getUIContext().getHostContext(),
      ["ohos.permission.READ_IMAGEVIDEO", "ohos.permission.CAMERA", "ohos.permission.WRITE_IMAGEVIDEO"],
      {
        onAllGranted: () => {
          this.goMain()
        },
        onDenied: (results: PermissionResult[]) => {
          PromptUtils.toastShort(this.getUIContext(), "授权申请失败，请在设置页面里手动打开权限")
        }
      })
  }

  private goMain() {
    setTimeout(() => {
      HMRouterMgr.replace({ pageUrl: RouterGuide.MainPage, animator : false })
    }, 1000) // 1秒后跳转
  }
}
