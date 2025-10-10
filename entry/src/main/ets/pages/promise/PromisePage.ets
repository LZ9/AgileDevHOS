import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import {
  BaseContainer,
  BaseContainerVm,
  CoreConstants,
  DataError,
  DateUtils,
  Disposable,
  JsonUtils,
  PromiseAgent,
  PromptUtils
} from '@lodz/pandora'
import { ApiService } from '../../api/ApiService'
import { InfoBean } from '../../bean/api/InfoBean'
import { ResponseData } from '../../bean/api/ResponseData'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { LogListView } from '../../view/LogListView'

/**
 * Promise测试类
 * Created by zhouL on 2025/8/6.
 */
@ComponentV2
@HMRouter({ pageUrl: "PromisePage" })
export struct PromisePage {
  @Local vm: BaseContainerVm = new BaseContainerVm()
  /** 日志列表 */
  @Local public logList: Array<string> = []
  /** 图片路径 */
  @Local public imgUri?: string
  /** 是否请求成功 */
  private isRequestSuccess: boolean = true
  /** 接口任务 */
  private disposable?: Disposable

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      HMRouterMgr.pop()
    }
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.promise_title')
    this.vm.onReloadClick = () => {
      this.requestNormal()
    }
  }

  onDidBuild(): void {
    this.vm.showStatusCompleted()
  }

  aboutToDisappear(): void {
    this.disposable?.dispose()
  }

  /** 请求代办列表 */
  private requestNormal() {
    this.vm.showStatusLoading()
    this.disposable = PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiService.create().getTodoList(this.getUIContext().getHostContext(), this.isRequestSuccess))
      .subscribe({
        onSubscribe: () => {
          this.vm.showStatusLoading()
        },
        onNext: (responseBean: ResponseBean<Array<TodoBean>>) => {
          this.addLog(JsonUtils.beanToJson(responseBean))
          this.vm.showStatusCompleted()
        },
        onError: (e: DataError<ResponseBean<Array<TodoBean>>>) => {
          PromptUtils.toastShort(this.getUIContext(), e.message)
          this.vm.showStatusError()
        }
      })
  }

  /** 请求代办列表（加载框） */
  private requestProgress() {
    this.disposable = PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiService.create().getTodoList(this.getUIContext().getHostContext(), this.isRequestSuccess))
      .subscribePgDef(this.getUIContext(),
        {
          onNext: (responseBean: ResponseBean<Array<TodoBean>>) => {
            this.addLog(JsonUtils.beanToJson(responseBean))
          },
          onError: (e: DataError<ResponseBean<Array<TodoBean>>>) => {
            PromptUtils.toastShort(this.getUIContext(), e.message)
          }
        }
      )
  }

  /** 使用get请求获取图片并保存到手机目录 */
  private requestImg(){
    PromiseAgent.create<string>()
      .then(() => ApiService.create().getImg())
      .subscribePgDef(this.getUIContext(), {
        onNext: (data: string) => {
          this.imgUri = data
        },
        onError: (e: DataError<string>) => {
          PromptUtils.toastShort(this.getUIContext(), e.message)
        }
      })
  }

  /** 使用post请求列表数据 */
  private requestInfoList(){
    PromiseAgent.create<ResponseData<InfoBean>>()
      .then(() => ApiService.create().postData())
      .subscribePgDef(this.getUIContext(), {
        onNext: (response: ResponseData<InfoBean>) => {
          const data = response.value
          if (data === undefined || data === null) {
            this.addLog("获取数据结果是空")
            return
          }
          const list = data.list ?? []
          for (let i = 0; i < list.length; i++) {
            const item = list[i]
            this.addLog(JsonUtils.beanToJson(item))
          }
        },
        onError: (e: DataError<ResponseData<InfoBean>>) => {
          PromptUtils.toastShort(this.getUIContext(), e.message)
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

      Image(this.imgUri)
        .width('100%')
        .height(150)
        .objectFit(ImageFit.Contain)
        .margin({ top: 5, bottom: 5 })
        .visibility(this.imgUri !== undefined ? Visibility.Visible : Visibility.None)

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
            this.requestProgress()
          })
      }
      .width('100%')
      .margin({ top: 5, bottom: 5 })

      Row() {
        Button($r('app.string.promise_request_get'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            this.requestImg()
          })

        Button($r('app.string.promise_request_post'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            this.requestInfoList()
          })
      }
      .width('100%')
      .margin({ top: 5, bottom: 5 })
    }
    .width('100%')
    .height('100%')
  }
}