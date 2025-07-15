import { RouterUtils } from 'pandora'

/**
 * 启动页
 * Created by zhouL on 2025/7/13.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
struct SplashPage {
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
    setTimeout(() => {
      RouterUtils.replaceUrl(this.getUIContext(), $r('app.string.main_page_path'))
    }, 2000) // 2秒后跳转
  }
}
