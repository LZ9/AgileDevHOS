import { PromptUtils, RouterUtils, StatusBarUtils, BaseContainer, BaseContainerVm, GroupBean,
  ArrayUtils } from '@lodz/pandora'
import { MainBean } from '../../bean/main/MainBean'

/**
 * 主页
 * Created by zhouL on 2025/7/14.
 */
@Entry
@ComponentV2
@Preview({ deviceType: "phone" })
struct MainPage {
  /** 索引字符数组 */
  private static readonly INDEX_ARRAY: string[] = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#']

  @Local private vm: BaseContainerVm = new BaseContainerVm()
  /** 列表数据 */
  private list: GroupBean<MainBean>[] = []
  /** 列表控制器 */
  private scroller: ListScroller = new ListScroller()
  /** 列表位置 */
  @Local listPosition: number = 0
  /** 索引栏位置 */
  private alphabetIndexerPosition: number = -1

  aboutToAppear(): void {
    //设置状态栏颜色
    StatusBarUtils.setColor(this.getUIContext().getHostContext(), $r('app.color.color_00A0E9'), Color.White)

    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.visibility = Visibility.Hidden
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.main_title')

    const data = [
      new MainBean("Json转换测试", "J", $r('app.string.json_page_path')),
      new MainBean("Preferences测试类", "P", $r('app.string.preferences_page_path')),
      new MainBean("Mvvm测试类", "M", $r('app.string.mvvm_page_path')),
      new MainBean("ComponentV2测试类", "C", $r('app.string.component_v2_page_path')),
      new MainBean("Promise测试类", "P", $r('app.string.promise_page_path'))
    ]

    this.list = ArrayUtils.group(data, MainPage.INDEX_ARRAY)
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
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
    // 列表和索引栏
    Stack() {
      // 列表
      List({ scroller: this.scroller }) {
        ForEach(this.list, (bean: GroupBean<MainBean>) => {
          ListItemGroup({ header: this.itemHeader(bean) }) {
            ForEach(bean.list, (item: MainBean) => {
              ListItem() {
                Text(item.getTitleName())
                  .width('100%')
                  .fontSize(16)
                  .fontColor($r('app.color.color_757575'))
                  .backgroundColor(Color.White)
                  .padding(10)
                  .onClick(() => {
                    RouterUtils.pushUrl(this.getUIContext(), item.getPagePath(this.getUIContext()))
                  })
              }
            })
          }
          .divider({ strokeWidth: 1, color: $r('app.color.color_EEEEEE') })
        })
      }
      .height('100%')
      .width('100%')
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
        .selectedColor(Color.White) // 索引条选中项文字颜色
        .selectedBackgroundColor(Color.Grey) // 索引条选中项背景颜色
        .itemBorderRadius(24) // 索引条选中项背景的圆角半径
        .selectedFont({ size: 16, weight: FontWeight.Bolder }) // 索引条选中项文字样式
        .onSelect((index: number) => {
          this.alphabetIndexerPosition = index //用户操作索引栏，记录位置
          this.scroller.scrollToIndex(index, true, ScrollAlign.START)
        })
    }
    .width('100%')
    .layoutWeight(1)
    .alignContent(Alignment.End)
  }

  @Builder
  private itemHeader(bean: GroupBean<MainBean>) {
    Text(bean.indexStr)
      .width('100%')
      .fontSize(16)
      .fontColor($r('app.color.color_999999'))
      .backgroundColor($r('app.color.color_EEEEEE'))
      .padding(10)
      .visibility(bean.list.length === 0 ? Visibility.None : Visibility.Visible)
  }
}

