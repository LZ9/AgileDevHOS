import { BaseContainer, BaseContainerVm, CoreConstants, DateUtils, JsonUtils, SelectorModifier } from '@lodz/pandora'
import { ResponseBean } from '../../bean/base/ResponseBean'
import { StudentBean } from '../../bean/json/StudentBean'
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
      this.vm.titleBarViewVm.titleVm.title = this.vm.navVm.getParamsValue<string>("title")
      this.vm.titleBarViewVm.backImgVm.onClick = () => {
        this.vm.navVm.back()
      }
      this.vm.showStatusCompleted()
    }
  }

  /** json字符串转bean对象 */
  private jsonToBean() {
    const bean = JsonUtils.jsonToBean<ResponseBean<Array<StudentBean>>>(JsonPage.JSON_STRING)
    let student = bean?.data?.[0]
    if (student === null || student === undefined) {
      this.addLog("解析失败")
      return
    }
    this.addLog(`解析成功：${student.name} , ${student.age} , ${student.city}`)
  }

  /** json字符串转bean时进行数据转换 */
  private jsonToBeanTransformer() {
    const bean = JsonUtils.jsonToBean<ResponseBean<Array<StudentBean>>>(JsonPage.JSON_STRING, this.transformer)
    let student = bean?.data?.[0]
    if (student === null || student === undefined) {
      this.addLog("解析失败")
      return
    }
    this.addLog(`解析变换成功：${student.name} , ${student.age} , ${student.city}`)
  }

  /** 对象转json字符串 */
  private beanToJson() {
    this.addLog(`转化成功：${JsonUtils.beanToJson(this.createResponseBean())}`)
  }

  /** 对象转json并过滤字段 */
  private beanToJsonFilter() {
    this.addLog(`只过滤msg和code：${JsonUtils.beanToJsonFilter(this.createResponseBean(), ["msg", "code"])}`)
  }

  /** 对象转json时数据转换 */
  private beanToJsonTransformer() {
    this.addLog(`解析变换成功：${JsonUtils.beanToJsonTransformer(this.createResponseBean(), this.transformer)}`)
  }

  /** 对象转json时格式化 */
  private beanToJsonForm() {
    this.addLog(`格式化json：${JsonUtils.beanToJsonForm(this.createResponseBean(), '  ')}`)
  }

  /** 对象是否包含某字段 */
  private hasField() {
    this.addLog(`ResponseBean是否包含data字段：${JsonUtils.has(this.createResponseBean(), "data")}`)
  }

  /** 对象里删除某字段 */
  private removeField() {
    const bean = this.createResponseBean()
    JsonUtils.remove(bean, "data")
    this.addLog(`删除data字段：${JsonUtils.beanToJson(bean)}`)
  }

  /** 清空日志 */
  private cleanLog() {
    this.logList = []
  }

  /**
   * 对json数据进行转换
   * @param key 键
   * @param value 值
   */
  private transformer(key: string, value: Object): Object | undefined | null {
    if (key === "age" && typeof value === 'number') {
      return value + 2
    }
    return value
  }

  /** 创建响应对象 */
  private createResponseBean(): ResponseBean<Array<StudentBean>> {
    const list = Array<StudentBean>()
    list.push(new StudentBean(1001, "Jack", 25, "Shanghai"))
    list.push(new StudentBean(1002, "Rose", 28, "Nanjing"))
    list.push(new StudentBean(1003, "Tom", 27, "Chengdu"))
    return ResponseBean.createSuccess<Array<StudentBean>>(list)
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
      Text(`原始Json字符串：${JsonPage.JSON_STRING}`)
        .fontSize(14)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Start)
        .margin(10)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))

      LogListView({ logList: this.logList })
        .layoutWeight(1)

      Line()
        .width(CoreConstants.LayoutParams.MATCH_PARENT)
        .height(1)
        .backgroundColor($r('app.color.color_D9D9D9'))

      Row() {
        //转bean对象
        Button($r('app.string.json_to_bean'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.jsonToBean()
          })

        //转bean时进行数据转换
        Button($r('app.string.json_to_bean_transformer'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.jsonToBeanTransformer()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        //转json字符串
        Button($r('app.string.json_to_json'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.beanToJson()
          })

        //转json并过滤
        Button($r('app.string.json_to_json_filter'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.beanToJsonFilter()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        //转json时数据转换
        Button($r('app.string.json_to_json_transformer'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.beanToJsonTransformer()
          })

        //转json时格式化
        Button($r('app.string.json_to_json_form'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.beanToJsonForm()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        //包含某字段
        Button($r('app.string.json_has'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ right: 10 })
          .onClick(() => {
            this.hasField()
          })

        //对象里删除某字段
        Button($r('app.string.json_remove'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .margin({ left: 10 })
          .onClick(() => {
            this.removeField()
          })
      }
      .width(CoreConstants.LayoutParams.MATCH_PARENT)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      Row() {
        Button($r('app.string.json_clean'), { type: ButtonType.Normal, stateEffect: true })
          .layoutWeight(1)
          .borderRadius(8)
          .fontColor(Color.White)
          .attributeModifier(new SelectorModifier($r('app.color.color_00A0E9'), $r('app.color.color_007DFF')))
          .fontSize(14)
          .onClick(() => {
            this.cleanLog()
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