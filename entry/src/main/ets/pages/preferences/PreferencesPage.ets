import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  DateUtils,
  JsonUtils,
  PreferencesUtils,
  PromptUtils,
  ResourceUtils,
  SelectorModifier,
  StringUtils,
} from '@lodz/pandora'
import { Constants } from '../../config/Constants'
import { preferences } from '@kit.ArkData';
import { LogListView } from '../../view/LogListView';
import { CacheManager } from '../../tools/CacheManager';

@Builder
export function PreferencesPageBuilder() {
  PreferencesPage()
}

/**
 * Preferences测试类
 * Created by zhouL on 2025/7/20.
 */
@ComponentV2
@Preview({ deviceType: "phone" })
export struct PreferencesPage {
  /** 日志列表 */
  @Local private logList: Array<string> = []
  /** 缓存内容 */
  @Local private text: string = ""
  /** 基类属性 */
  @Local vm: BaseContainerVm = new BaseContainerVm()

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>()
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.showStatusCompleted()
    }
  }

  /** 清空日志 */
  private cleanLog() {
    this.logList = []
  }

  /** 保存文字 */
  private saveText() {
    if (StringUtils.isEmpty(this.text)) {
      PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_input_hint'))
      return
    }
    CacheManager.putUserText(this.text)
    this.addLog("保存文字：" + this.text)
  }

  /** 读取文字 */
  private readText() {
    const value = CacheManager.getUserText()
    this.addLog("读取文字：" + value)
  }

  /** 读取文字 */
  private readAll() {
    this.addLog("获取全部缓存数据：" + JsonUtils.beanToJson(PreferencesUtils.get().getAllSync()))
  }

  /** 是否有数据 */
  private hasText() {
    const keys = PreferencesUtils.get().getAllKeysSync()
    if (keys.length === 0) {
      PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_no_data'))
      return
    }
    let buttons: CoreConstants.Prompt.MenuBtn = [{
      text: "error_key",
      color: $r('app.color.color_757575')
    }]
    keys.forEach((key) => {
      buttons.push({
        text: key,
        color: $r('app.color.color_757575')
      })
    })
    PromptUtils.menu(this.getUIContext(), buttons, "选择要查看的key")
      .then((result) => {
        let btn = buttons[result.index]
        if (btn === undefined) {
          throw new Error("未找到key")
        }
        return ResourceUtils.getString(this.getUIContext().getHostContext(), btn.text)
      })
      .then((key) => {
        this.addLog(key + " 查询结果：" + PreferencesUtils.get().hasSync(key))
      })
      .catch((e: Error) => {
        this.addLog("查询失败：" + e.message)
      })
  }

  /** 删除数据 */
  private deleteText() {
    const keys = PreferencesUtils.get().getAllKeysSync()
    if (keys.length === 0) {
      PromptUtils.toastShort(this.getUIContext(), $r('app.string.preferences_no_data'))
      return
    }
    let buttons: CoreConstants.Prompt.MenuBtn = [{
      text: keys.shift() ?? "",
      color: $r('app.color.color_757575')
    }]
    keys.forEach((key) => {
      buttons.push({
        text: key,
        color: $r('app.color.color_757575')
      })
    })
    PromptUtils.menu(this.getUIContext(), buttons, "选择要删除数据的key")
      .then((result) => {
        let btn = buttons[result.index]
        if (btn === undefined) {
          throw new Error("未找到key")
        }
        return ResourceUtils.getString(this.getUIContext().getHostContext(), btn.text)
      })
      .then((key) => {
        PreferencesUtils.get().deleteSync(key)
        this.addLog(key + " 数据已删除")
      })
      .catch((e: Error) => {
        this.addLog("查询失败：" + e.message)
      })
  }

  /** 清空所有数据 */
  private clearAll() {
    PreferencesUtils.get().clearSync()
  }

  /** 开启全量订阅 */
  private onChange() {
    PreferencesUtils.get().onChange(this.onChangeCallback)
  }

  /** 关闭全量订阅 */
  private offChange() {
    PreferencesUtils.get().offChange(this.onChangeCallback)
  }

  /** 数据变动key值回调 */
  private onChangeCallback: Callback<string> = (key: string) => {
    this.addLog(key + " 数据变动")
  }

  /** 开启精确订阅 */
  private onDataChange() {
    PreferencesUtils.get().onDataChange(Constants.Preferences.USER_KEY, this.onDataChangeCallback)
  }

  /** 关闭精确订阅 */
  private offDataChange() {
    PreferencesUtils.get().offDataChange(Constants.Preferences.USER_KEY, this.onDataChangeCallback)
  }

  /** 数据变动回调 */
  private onDataChangeCallback: Callback<Record<string, preferences.ValueType>> =
    (data: Record<string, preferences.ValueType>) => {
      const key = Object.keys(data)
      this.addLog(key[0] + " 数据变动，变动值为：" + data[key[0]])
    }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_8) + " ---> " + text)
  }

  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentComponent()
        }
      })
    }
  }

  @Builder
  contentComponent() {
    Column() {
      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))

      // 值输入框
      Row() {
        Text($r('app.string.preferences_save_title'))
          .fontSize(14)
          .margin({ left: 10 })

        TextInput({ text: $$this.text, placeholder: $r('app.string.preferences_input_hint'), })
          .type(InputType.Normal)
          .placeholderFont({ size: 14 })
          .margin({ left: 10, right: 10 })
          .layoutWeight(1)

        //清空日志
        Button($r('app.string.preferences_clear_log'), { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.cleanLog()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })

      Row() {
        //同步保存
        Button($r('app.string.preferences_save'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .onClick(() => {
            this.saveText()
          })

        //同步读取
        Button($r('app.string.preferences_read'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.readText()
          })

        //同步获取全部
        Button($r('app.string.preferences_get_all'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .onClick(() => {
            this.readAll()
          })

      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        //是否有数据
        Button($r('app.string.preferences_has'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .onClick(() => {
            this.hasText()
          })

        //删除数据
        Button($r('app.string.preferences_delete'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.deleteText()
          })

        //清空所有
        Button($r('app.string.preferences_clean'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .onClick(() => {
            this.clearAll()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })



      Row() {
        //开启全量订阅
        Button($r('app.string.preferences_change_on'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.onChange()
          })

        //关闭全量订阅
        Button($r('app.string.preferences_change_off'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.offChange()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        //开启精确订阅
        Button($r('app.string.preferences_data_change_on'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.onDataChange()
          })

        //关闭精确订阅
        Button($r('app.string.preferences_data_change_off'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.offDataChange()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }


}