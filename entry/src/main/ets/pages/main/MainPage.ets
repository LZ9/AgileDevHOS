import { PromptUtils, RouterUtils, StatusBarUtils, BaseContainer, BaseContainerVm, IdCardUtils } from '@lodz/pandora'
import { MainBean } from '../../bean/main/MainBean'

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@Entry
@ComponentV2
@Preview({ deviceType: "phone" })
struct MainPage {
  /** 列表数据 */
  private list: Array<MainBean> = []
  @Local private vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    //设置状态栏颜色
    StatusBarUtils.setColor(this.getUIContext().getHostContext(), $r('app.color.color_00A0E9'), Color.White)

    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.visibility = Visibility.Hidden
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.main_title')

    this.list = [
      new MainBean("Json转换测试", $r('app.string.json_page_path')),
      new MainBean("Preferences测试类", $r('app.string.preferences_page_path')),
      new MainBean("Mvvm测试类", $r('app.string.mvvm_page_path')),
      new MainBean("ComponentV2测试类", $r('app.string.component_v2_page_path')),
      new MainBean("Promise测试类", $r('app.string.promise_page_path'))
    ]
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
    IdCardUtils.validateIdCard("990203199107313017")
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentLayout()
        },
        titleBarExpandLayout: () => {
          this.expandLayout()
        }
      })
    }
  }

  @Builder
  expandLayout() {
    Text($r('app.string.main_change_mood'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })
      .onClick(() => {
        PromptUtils.toastShort(this.getUIContext(), "刷新")
      })
  }

  @Builder
  contentLayout() {
    // 列表
    List() {
      ForEach(this.list, (item: MainBean) => {
        ListItem() {
          Text(item.getTitleName())
            .width('100%')
            .fontSize(20)
            .textAlign(TextAlign.Start)
            .padding(10)
            .onClick(() => {
              RouterUtils.pushUrl(this.getUIContext(), item.getPagePath(this.getUIContext()))
            })
        }
      })
    }
    .height('100%')
    .width('100%')
    .alignListItem(ListItemAlign.Center)
  }
}

