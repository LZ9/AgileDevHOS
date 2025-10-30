import {
  CoreConstants,
  NavContainerVm,
  NavDesContainer,
  PermissionGrantUtils,
  PermissionResult,
  PromptUtils
} from '@lodz/pandora'
import { RouterGuide } from '../../config/RouterGuide'

@Builder
export function SplashPageBuilder() {
  SplashPage()
}

/**
 * 启动页
 * Created by zhouL on 2025/7/13.
 */
@ComponentV2
@Preview({ deviceType: "phone" })
export struct SplashPage {
  @Local private vm: NavContainerVm = new NavContainerVm()

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
      this.vm.stack.replacePathByName(RouterGuide.MainPage, undefined, false)
    }, 1000) // 1秒后跳转
  }

  build() {
    NavDesContainer({
      vm: this.vm,
      contentLayout: () => {
        this.contentComponent()
      }
    })
  }

  @Builder
  contentComponent() {
    Stack() {
      Image($r(`app.media.bg_splash`))
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(CoreConstants.LayoutParams.MATCH_PARENT)
        .objectFit(ImageFit.Cover)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 设置图片覆盖顶部状态栏和底部导航栏

      Text($r(`app.string.splash_title`))
        .fontSize(24)
        .fontColor(Color.White)
        .margin({ top: 100 })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
    .alignContent(Alignment.Top) // 设置内容垂直顶部对齐
  }
}
