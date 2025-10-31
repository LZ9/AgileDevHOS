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
import { ApiManager } from '../../api/ApiManager'
import { ActivityListBean } from '../../bean/api/ActivityListBean'
import { ResponseData } from '../../bean/api/ResponseData'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { TodoBean } from '../../bean/mvvm/TodoBean'
import { LogListView } from '../../view/LogListView'

@Builder
export function PromisePageBuilder() {
  PromisePage()
}

/**
 * Promise测试类
 * Created by zhouL on 2025/8/6.
 */
@ComponentV2
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
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>("title")
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.onReloadClick = () => {
        this.requestNormal()
      }
      this.vm.showStatusCompleted()
    }
  }

  aboutToDisappear(): void {
    this.disposable?.dispose()
  }

  /** 请求代办列表 */
  private requestNormal() {
    this.vm.showStatusLoading()
    this.disposable = PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiManager.create().getTodoList(this.getUIContext().getHostContext(), this.isRequestSuccess))
      .subscribe({
        onSubscribe: () => {
          this.vm.showStatusLoading()
        },
        onNext: (responseBean: ResponseBean<Array<TodoBean>>) => {
          this.addLog(JsonUtils.beanToJson(responseBean))
          this.vm.showStatusCompleted()
        },
        onError: (e: DataError<ResponseBean<Array<TodoBean>>>) => {
          PromptUtils.toastShort(this.getUIContext(), e.getTips())
          this.vm.showStatusError()
        }
      })
  }

  /** 请求代办列表（加载框） */
  private requestProgress() {
    this.disposable = PromiseAgent.create<ResponseBean<Array<TodoBean>>>()
      .then(() => ApiManager.create().getTodoList(this.getUIContext().getHostContext(), this.isRequestSuccess))
      .subscribePgDef(this.getUIContext(),
        {
          onNext: (responseBean: ResponseBean<Array<TodoBean>>) => {
            this.addLog(JsonUtils.beanToJson(responseBean))
          },
          onError: (e: DataError<ResponseBean<Array<TodoBean>>>) => {
            PromptUtils.toastShort(this.getUIContext(), e.getTips())
          }
        }
      )
  }

  /** 使用get请求获取图片并保存到手机目录 */
  private requestImg(){
    PromiseAgent.create<string>()
      .then(() => ApiManager.create().getImg())
      .subscribePgDef(this.getUIContext(), {
        onNext: (data: string) => {
          this.imgUri = data
        },
        onError: (e: DataError<string>) => {
          PromptUtils.toastShort(this.getUIContext(), e.getTips())
        }
      })
  }

  /** 使用post请求列表数据 */
  private requestInfoList(){
    PromiseAgent.create<ResponseData<ActivityListBean>>()
      .then(() => ApiManager.create().getActivityList(1))
      .subscribePgDef(this.getUIContext(), {
        onNext: (response: ResponseData<ActivityListBean>) => {
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
        onError: (e: DataError<ResponseData<ActivityListBean>>) => {
          PromptUtils.toastShort(this.getUIContext(), e.getTips())
        }
      })
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
        },
        titleBarExpandLayout: () => {
          this.expandComponent()
        }
      })
    }
  }

  @Builder
  expandComponent() {
    Text($r('app.string.promise_success_switch'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ right: 10 })

    Toggle({ type: ToggleType.Switch, isOn: true })
      .selectedColor($r('app.color.color_007DFF'))
      .switchPointColor(Color.White)
      .onChange((isOn: boolean) => {
        this.isRequestSuccess = isOn
      })
  }

  @Builder
  contentComponent() {
    Column() {
      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Image(this.imgUri)
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(150)
        .objectFit(ImageFit.Contain)
        .margin({ top: 5, bottom: 5 })
        .visibility(this.imgUri !== undefined ? Visibility.Visible : Visibility.None)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))

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
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
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
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 5, bottom: 5 })
    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }
}