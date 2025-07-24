import {
  CoreConstants,
  DateUtils,
  DeviceUtils,
  PreferencesUtils,
  PromptUtils,
  ResourceUtils,
  RouterUtils,
  StringUtils,
  TitleBarView,
  TitleBarViewAttribute
} from 'pandora'
import { Constants } from '../../config/Constants'
import { preferences } from '@kit.ArkData';

/**
 * Preferences测试类
 * Created by zhouL on 2025/7/20.
 */
@Entry
@Component
@Preview({ deviceType: "phone" })
struct PreferencesPage {
  /** 日志列表 */
  @State private logList: Array<string> = []
  /** 缓存内容 */
  private text: string = ""
  /** 列表滚动栏 */
  private listScroller: ListScroller = new ListScroller();
  /** 标题栏属性 */
  @State attribute: TitleBarViewAttribute = new TitleBarViewAttribute()

  aboutToAppear(): void {
    this.attribute = this.configTitleBarViewAttribute()
  }

  /** 配置标题栏熟悉 */
  private configTitleBarViewAttribute(): TitleBarViewAttribute {
    const attribute = new TitleBarViewAttribute()
    attribute.backImgOptions.onClick = (event: ClickEvent) => {
      RouterUtils.back(this.getUIContext())
    }
    attribute.titleOptions.title = $r('app.string.preferences_title')
    attribute.titleOptions.backgroundColor = $r('app.color.color_00a0e9')
    return attribute
  }

  build() {
    Column() {
      TitleBarView({ attribute: this.attribute })

      List({ scroller: this.listScroller }) {
        ForEach(this.logList, (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(14)
              .padding(5)
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Start)

      Line()
        .width('100%')
        .height(1)
        .backgroundColor(Color.Grey)

      // 值输入框
      Row() {
        Text($r('app.string.preferences_save_title'))
          .fontSize(14)
          .margin({ left: 10 })

        TextInput({ placeholder: $r('app.string.preferences_input_hint'), })
          .type(InputType.Normal)
          .placeholderFont({ size: 14 })
          .margin({ left: 10, right: 10 })
          .layoutWeight(1)
          .onChange((value) => {
            this.text = value
          })

        //清空日志
        Button($r('app.string.preferences_clear_log'))
          .padding({ left: 10, right: 10 })
          .fontSize(14)
          .onClick(() => {
            this.logList = []
          })
      }
      .margin({ top: 10 })

      Text($r('app.string.preferences_sync'))
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //同步保存
        Button($r('app.string.preferences_save'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            if (StringUtils.isEmpty(this.text)) {
              PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
              return
            }
            PreferencesUtils.getInstance().putSync(Constants.Preferences.USER_KEY, this.text)
            this.addLog("同步保存字符：" + this.text)
          })

        //同步读取
        Button($r('app.string.preferences_read'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const def = ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_text_def'))
            const value = PreferencesUtils.getInstance().getSync(Constants.Preferences.USER_KEY, def)
            this.addLog("同步读取字符：" + value)
          })

        //同步获取全部
        Button($r('app.string.preferences_get_all'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            this.addLog("同步获取全部数据：" + JSON.stringify(PreferencesUtils.getInstance().getAllSync()))
          })
      }

      Text($r('app.string.preferences_async'))
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //异步保存
        Button($r('app.string.preferences_save'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            if (StringUtils.isEmpty(this.text)) {
              PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
              return
            }
            PreferencesUtils.getInstance().put(Constants.Preferences.USER_KEY, this.text)
              .then(() => {
                this.addLog("异步保存字符成功：" + this.text)
              })
              .catch((e: Error) => {
                this.addLog("异步保存字符失败：" + e.message)
              })
          })

        //异步读取
        Button($r('app.string.preferences_read'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const def = ResourceUtils.toString(this.getUIContext().getHostContext(), $r('app.string.preferences_text_def'))
            PreferencesUtils.getInstance().get(Constants.Preferences.USER_KEY, def)
              .then((value) => {
                this.addLog("异步读取字符成功：" + value)
              })
              .catch((e: Error) => {
                this.addLog("异步读取字符失败：" + e.message)
              })
          })

        //异步获取全部
        Button($r('app.string.preferences_get_all'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().getAll()
              .then((data) => {
                this.addLog("同步获取全部数据成功：" + JSON.stringify(data))
              })
              .catch((e: Error) => {
                this.addLog("异步获取全部数据失败：" + e.message)
              })
          })
      }

      Text($r('app.string.preferences_other'))
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //是否有数据
        Button($r('app.string.preferences_has'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const keys = PreferencesUtils.getInstance().getAllKeysSync()
            if (keys.length === 0) {
              PromptUtils.toastShort(this.getUIContext(), "无数据")
              return
            }
            let buttons: CoreConstants.Prompt.MenuBtn = [{
              text: "error_key",
              color: '#666666'
            }]
            keys.forEach((key) => {
              buttons.push({
                text: key,
                color: '#666666'
              })
            })
            PromptUtils.menu(this.getUIContext(), buttons, "选择要查看的key")
              .then((result) => {
                let btn = buttons[result.index]
                if (btn === undefined) {
                  throw new Error("未找到key")
                }
                return ResourceUtils.toString(this.getUIContext().getHostContext(), btn.text)
              })
              .then((key) => {
                this.addLog(key + " 查询结果：" + PreferencesUtils.getInstance().hasSync(key))
              })
              .catch((e: Error) => {
                this.addLog("查询失败：" + e.message)
              })
          })

        //删除数据
        Button($r('app.string.preferences_delete'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const keys = PreferencesUtils.getInstance().getAllKeysSync()
            if (keys.length === 0) {
              PromptUtils.toastShort(this.getUIContext(), "无数据")
              return
            }
            let buttons: CoreConstants.Prompt.MenuBtn = [{
              text: keys.shift() ?? "",
              color: '#666666'
            }]
            keys.forEach((key) => {
              buttons.push({
                text: key,
                color: '#666666'
              })
            })
            PromptUtils.menu(this.getUIContext(), buttons, "选择要删除数据的key")
              .then((result) => {
                let btn = buttons[result.index]
                if (btn === undefined) {
                  throw new Error("未找到key")
                }
                return ResourceUtils.toString(this.getUIContext().getHostContext(), btn.text)
              })
              .then((key) => {
                PreferencesUtils.getInstance().deleteSync(key)
                this.addLog(key + " 数据已删除")
              })
              .catch((e: Error) => {
                this.addLog("查询失败：" + e.message)
              })
          })

        //清空所有
        Button($r('app.string.preferences_clean'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().clear()
              .then(() => {
                this.addLog("清空完成")
              })
              .catch((e: Error) => {
                this.addLog("清空失败：" + e.message)
              })
          })
      }

      Text($r('app.string.preferences_subscribe'))
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //开启全量订阅
        Button($r('app.string.preferences_change_on'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().onChange(this.mCallback)
          })

        //关闭全量订阅
        Button($r('app.string.preferences_change_off'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().offChange(this.mCallback)
          })
      }

      Row() {
        //开启精确订阅
        Button($r('app.string.preferences_data_change_on'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().onDataChange(Constants.Preferences.USER_KEY, this.mDataCallback)
          })

        //关闭精确订阅
        Button($r('app.string.preferences_data_change_off'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            PreferencesUtils.getInstance().offDataChange(Constants.Preferences.USER_KEY, this.mDataCallback)
          })
      }
      .margin({ top: 10 })

    }
    .width('100%')
    .height('100%')
  }

  /** 数据变动key值回调 */
  private mCallback: Callback<string> = (key: string) => {
    this.addLog(key + " 数据变动")
  }
  /** 数据变动回调 */
  private mDataCallback: Callback<Record<string, preferences.ValueType>> =
    (data: Record<string, preferences.ValueType>) => {
      const key = Object.keys(data)
      this.addLog(key[0] + " 数据变动，变动值为：" + data[key[0]])
    }

  /**
   * 打印日志
   * @param text 日志
   */
  private addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_1) + " : " + text)
    this.listScroller.scrollTo({ xOffset: 0, yOffset: DeviceUtils.getScreenHeight(), animation: true })
  }
}