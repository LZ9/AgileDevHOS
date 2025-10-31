import {
  StatusBarUtils,
  BaseContainer,
  BaseContainerVm,
  GroupBean,
  ArrayUtils,
  RandomUtils,
  PromptUtils,
  CoreConstants,
} from '@lodz/pandora'
import { MainBean } from '../../bean/main/MainBean'
import { RouterGuide } from '../../config/RouterGuide'

@Builder
export function MainPageBuilder() {
  MainPage()
}

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@ComponentV2
@Preview({ deviceType: "phone" })
export struct MainPage {
  /** 索引字符数组 */
  private static readonly INDEX_ARRAY: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#']
  /** 颜色 */
  private static readonly COLORS: ResourceColor[] = [
    $r('app.color.color_00A0E9'), $r('app.color.color_EA8380'), $r('app.color.color_EA413C'),
    $r('app.color.color_303F9F'), $r('app.color.color_FF4081'), $r('app.color.color_D28928'),
    $r('app.color.color_464646')
  ]
  /** 表情编码 */
  private static readonly EMOJI_UNICODE: number[] = [
    0x1F601, 0x1F602, 0x1F603, 0x1F604, 0x1F605, 0x1F606, 0x1F609, 0x1F60A, 0x1F60B, 0x1F60C, 0x1F60D, 0x1F60E, 0x1F60F,
    0x1F612, 0x1F613, 0x1F614, 0x1F616, 0x1F618, 0x1F61A, 0x1F61C, 0x1F61D, 0x1F61E, 0x1F620, 0x1F621, 0x1F622, 0x1F623,
    0x1F624, 0x1F625, 0x1F628, 0x1F629, 0x1F62A, 0x1F62B, 0x1F62D, 0x1F630, 0x1F631, 0x1F632, 0x1F633, 0x1F634, 0x1F635,
    0x1F637, 0x1F638, 0x1F639, 0x1F63A, 0x1F63B, 0x1F63C, 0x1F63D, 0x1F63E, 0x1F63F
  ]

  @Local private vm: BaseContainerVm = new BaseContainerVm()
  /** 列表数据 */
  @Local private list: GroupBean<MainBean>[] = []
  /** 列表控制器 */
  private scroller: ListScroller = new ListScroller()
  /** 列表位置 */
  @Local private listPosition: number = 0
  /** 上一次点击返回退出的时间 */
  private lastExitTime = 0
  /** 索引栏位置 */
  private alphabetIndexerPosition: number = -1

  aboutToAppear(): void {
    //设置状态栏颜色
    StatusBarUtils.setColor(this.getUIContext().getHostContext(), $r('app.color.color_00A0E9'), Color.White)
    this.vm.setScopeConfig()
    this.vm.navVm.onBackPressed = () => {
      const time = new Date().getTime()
      if (time - this.lastExitTime > 1000) {
        this.lastExitTime = time
        PromptUtils.toastShort(this.getUIContext(), '再次返回退出应用')
        return true
      }
      return false
    }
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.backImgVm.visibility = Visibility.Hidden
      this.vm.titleBarViewVm.titleVm.title = $r('app.string.main_title')

      const data = [
        new MainBean($r('app.string.json_title'), "J", RouterGuide.JsonPage),
        new MainBean($r('app.string.preferences_title'), "P", RouterGuide.PreferencesPage),
        new MainBean($r('app.string.mvvm_title'), "M", RouterGuide.MvvmPage),
        new MainBean($r('app.string.component_v2_title'), "C", RouterGuide.ComponentV2Page),
        new MainBean($r('app.string.promise_title'), "P", RouterGuide.PromisePage),
        new MainBean($r('app.string.refresh_load_title'), "S", RouterGuide.RefreshLoadPage),
        new MainBean($r('app.string.event_bus_title'), "E", RouterGuide.EventBusPage)
      ]
      this.list = ArrayUtils.group(data, MainPage.INDEX_ARRAY)
    }
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
  }

  /** 获取随机颜色 */
  private getRandomColor(): ResourceColor {
    return MainPage.COLORS[RandomUtils.getInt(0, MainPage.COLORS.length)]
  }

  /** 获取随机emoji表情 */
  private getRandomEmoji(): number {
    return MainPage.EMOJI_UNICODE[RandomUtils.getInt(0, MainPage.EMOJI_UNICODE.length)]
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentComponent()
        },
        titleBarExpandLayout: () => {
          this.expandComponent()
        }
      })
    }
  }

  @Builder
  expandComponent() {
    Text($r('app.string.main_change_mood'))
      .height(`100%`)
      .fontSize(14)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })
      .onClick(() => {
        for (let item of this.list) {
          for (let bean of item.list) {
            bean.id = RandomUtils.getUUID()
          }
        }
      })
  }

  @Builder
  contentComponent() {
    // 列表和索引栏
    Stack() {
      // 列表
      List({ scroller: this.scroller }) {
        ForEach(this.list, (bean: GroupBean<MainBean>) => {
          ListItemGroup({ header: this.itemHeader(bean) }) {
            ForEach(bean.list, (item: MainBean) => {
              ListItem() {
                Text(String.fromCodePoint(this.getRandomEmoji()) + "   " + item.getTitleName(this.getUIContext().getHostContext()))
                  .width(CoreConstants.LayoutParams.MATCH_PARENT)
                  .fontSize(16)
                  .fontColor(this.getRandomColor())
                  .backgroundColor(Color.White)
                  .padding(10)
                  .onClick(() => {
                    const params: Record<string, Object> = { 'title': item.getTitleName(this.getUIContext().getHostContext()) }
                    this.vm.navVm.pushPathOpt(item.getPage(), params)
                  })
              }
            }, (bean: MainBean) => bean.id)
          }
          .divider({ strokeWidth: 1, color: $r('app.color.color_EEEEEE') })
        })
      }
      .height(CoreConstants.LayoutParams.MATCH_PARENT)
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .sticky(StickyStyle.Header)
      .scrollBar(BarState.Off)
      .onScrollStop(() => {
        this.alphabetIndexerPosition = -1 // 列表停止滑动时索引栏位置置为-1
      })
      .onScrollIndex((index: number) => {
        if (this.alphabetIndexerPosition === -1) { // 如果用户没有操作索引栏正常更新
          this.listPosition = index
          return
        }
        if (index === this.alphabetIndexerPosition) { // 如果用户有操作索引栏，则列表索引位置和索引栏位置一致时才更新
          this.listPosition = index
          this.alphabetIndexerPosition = -1
        }
      })

      // 索引栏
      AlphabetIndexer({ arrayValue: MainPage.INDEX_ARRAY, selected: this.listPosition })
        .autoCollapse(false) // 关闭自适应折叠模式
        .enableHapticFeedback(false) // 关闭触控反馈
        .itemSize(28) // 索引项的尺寸大小
        .color($r('app.color.color_00A0E9'))
        .selectedColor(Color.White) // 索引条选中项文字颜色
        .selectedBackgroundColor($r('app.color.color_00A0E9')) // 索引条选中项背景颜色
        .itemBorderRadius(24) // 索引条选中项背景的圆角半径
        .selectedFont({ size: 16, weight: FontWeight.Bolder }) // 索引条选中项文字样式
        .onSelect((index: number) => {
          this.alphabetIndexerPosition = index //用户操作索引栏，记录位置
          this.scroller.scrollToIndex(index, true, ScrollAlign.START)
        })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .layoutWeight(1)
    .alignContent(Alignment.End)
  }

  @Builder
  private itemHeader(bean: GroupBean<MainBean>) {
    Text(bean.indexStr)
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .fontSize(16)
      .fontColor($r('app.color.color_00A0E9'))
      .fontWeight(FontWeight.Bold)
      .backgroundColor($r('app.color.color_F0F0F0'))
      .padding({left: 10, right: 10, top: 5, bottom: 5})
      .visibility(bean.list.length === 0 ? Visibility.None : Visibility.Visible)
  }
}

