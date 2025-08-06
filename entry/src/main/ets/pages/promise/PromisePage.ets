import { BaseContainer, BaseContainerVm,
  CoreConstants,
  DateUtils,
  JsonUtils, PromiseAgent, PromptUtils, RouterUtils } from '@lodz/pandora'
import { ApiService } from '../../api/ApiService'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { LogListView } from '../../view/LogListView'

/**
 * Promise测试类
 * Created by zhouL on 2025/8/6.
 */
@Entry
@ComponentV2
struct PromisePage {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  /** 日志列表 */
  @Local public logList: Array<string> = []
  /** 是否请求成功 */
  @Local public isRequestSuccess: boolean = true

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.promise_title')
    this.vm.onReloadClick = () => {
      this.requestNormal()
    }
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
  }

  /** 请求代办列表 */
  private requestNormal() {
    this.vm.showStatusLoading()
    PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiService.create().getTodoList(this.getUIContext().getHostContext(), this.isRequestSuccess))
      .subscribe({
        onSubscribe: () => {
          this.vm.showStatusLoading()
        },
        onNext: (responseBean: ResponseBean<Array<TodoBean>>) => {
          this.addLog(JsonUtils.beanToJson(responseBean))
          this.vm.showStatusCompleted()
        },
        onError: (e: Error) => {
          PromptUtils.toastShort(this.getUIContext(), e.message)
          this.vm.showStatusError()
        }
      })
  }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_1) + " ---> " + text)
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
    Text($r('app.string.promise_success_switch'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })

    Toggle({ type: ToggleType.Switch, isOn: true })
      .selectedColor($r('app.color.color_007DFF'))
      .switchPointColor($r('app.color.color_FFFFFF'))
      .onChange((isOn: boolean) => {
        this.isRequestSuccess = isOn
      })
  }

  @Builder
  contentLayout() {
    Column() {
      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Line()
        .width('100%')
        .height(1)
        .backgroundColor(Color.Grey)

      Row() {
        Button($r('app.string.promise_request_normal'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            this.requestNormal()
          })

        Button($r('app.string.promise_request_dialog'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {

          })
      }
      .width('100%')
      .margin({ top: 5, bottom: 5 })
    }
    .width('100%')
    .height('100%')
  }
}