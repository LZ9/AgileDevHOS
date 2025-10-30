import { BaseContainer, BaseContainerVm, CoreConstants, DateUtils, JsonUtils } from '@lodz/pandora'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { StudentBean } from '../../bean/json/StudentBean'
import { RouterGuide } from '../../config/RouterGuide'
import { LogListView } from '../../view/LogListView'

@Builder
export function JsonPageBuilder() {
  JsonPage()
}

/**
 * Json转换测试
 * Created by zhouL on 2025/7/19.
 */
@ComponentV2
export struct JsonPage {
  /** 默认Json字符串 */
  private static readonly JSON_STRING = '{"msg":"查询成功","code":200,"data":[{"id":1001,"name":"Jack","age":25,"city":"Shanghai"}]}'
  /** 基类属性 */
  @Local vm: BaseContainerVm = new BaseContainerVm()
  /** 日志列表 */
  @Local public logList: Array<string> = []

  aboutToAppear(): void {
    this.vm.setScopeConfig()
    this.vm.navVm.onAppear = () => {
      this.vm.titleBarViewVm.titleVm.title = RouterGuide.getParamsValue<string>("title", this.vm.navVm.pathInfo)
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.stack.pop()
      }
      this.vm.showStatusCompleted()
    }
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
      Text(`原始Json字符串：${JsonPage.JSON_STRING}`)
        .fontSize(14)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Start)
        .margin(10)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor(Color.Grey)

      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor(Color.Grey)

      Text($r('app.string.json_json_to_bean'))
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //转bean对象
        Button($r('app.string.json_to_bean'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const bean = JsonUtils.jsonToBean<ResponseBean<Array<StudentBean>>>(JsonPage.JSON_STRING)
            let student = bean?.data?.[0]
            if (student === null || student === undefined) {
              this.addLog("解析失败")
              return
            }
            this.addLog(`name : ${student.name} , age : ${student.age}`)
          })

        //转bean时进行数据转换
        Button($r('app.string.json_to_bean_transformer'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const bean = JsonUtils.jsonToBean<ResponseBean<Array<StudentBean>>>(JsonPage.JSON_STRING, this.transformer)
            let student = bean?.data?.[0]
            if (student === null || student === undefined) {
              this.addLog("解析失败")
              return
            }
            this.addLog(`所有age+2 ：name : ${student.name} , age : ${student.age}`)
          })
      }

      Text($r('app.string.json_bean_to_json'))
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //转json字符串
        Button($r('app.string.json_to_json'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const json = JsonUtils.beanToJson(this.createResponseBean())
            this.addLog(`json : ${json}`)
          })

        //转json并过滤
        Button($r('app.string.json_to_json_filter'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const json = JsonUtils.beanToJson(this.createResponseBean(), ["msg", "code"])
            this.addLog(`只过滤msg和code的json : ${json}`)
          })
      }

      Row() {
        //转json时数据转换
        Button($r('app.string.json_to_json_transformer'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const json = JsonUtils.beanToJson(this.createResponseBean(), undefined, this.transformer)
            this.addLog(`所有age+2的json : ${json}`)
          })

        //转json时格式化
        Button($r('app.string.json_to_json_form'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const json = JsonUtils.beanToJson(this.createResponseBean(), undefined, undefined, '  ')
            this.addLog(`格式化json : ${json}`)
          })
      }
      .margin({ top: 5 })

      Text($r('app.string.json_other'))
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .padding({
          left: 10,
          right: 10,
          top: 5,
          bottom: 5
        })

      Row() {
        //包含某字段
        Button($r('app.string.json_has'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const has = JsonUtils.has(this.createResponseBean(),"data")
            this.addLog(`是否包含data字段 : ${has}`)
          })

        //删除某字段
        Button($r('app.string.json_remove'))
          .layoutWeight(1)
          .fontSize(14)
          .margin({ left: 5, right: 5 })
          .onClick(() => {
            const bean = this.createResponseBean()
            JsonUtils.remove(bean, "data")
            const has = JsonUtils.has(bean, "data")
            this.addLog(`调用remove删除data字段后再判断 : ${has}`)
          })
      }

      Row() {
        Button($r('app.string.json_clean'))
          .layoutWeight(1)
          .fontSize(14)
          .margin(5)
          .onClick(() => {
            this.logList = []
          })
      }

    }
    .width(CoreConstants.LayoutParams.MATCH_PARENT)
    .height(CoreConstants.LayoutParams.MATCH_PARENT)
  }

  /** 创建响应对象 */
  private createResponseBean(): ResponseBean<Array<StudentBean>> {
    const list = Array<StudentBean>()
    list.push(new StudentBean(1001, "Jack", 25, "Shanghai"))
    list.push(new StudentBean(1002, "Rose", 28, "Nanjing"))
    list.push(new StudentBean(1003, "Tom", 27, "Chengdu"))
    return ResponseBean.createSuccess<Array<StudentBean>>(list, `查询成功`)
  }

  /**
   * 对json数据进行转换
   * @param key 键
   * @param value 值
   */
  private transformer(key: string, value: Object): Object | undefined | null {
    if (key === "age" && typeof value === 'number' && value !== undefined && value !== null) {
      return value + 2
    }
    return value
  }

  /**
   * 打印日志
   * @param text 日志
   */
  public addLog(text: string) {
    this.logList.push(DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_1) + " ---> " + text)
  }
}