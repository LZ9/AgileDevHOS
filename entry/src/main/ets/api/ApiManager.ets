import { FileUtils, JsonUtils, ResourceUtils, StringUtils } from "@lodz/pandora";
import { ResponseBean } from "../bean/base/ResponseBean";
import { TodoBean } from "../bean/mvvm/TodoBean";
import rcp from "@hms.collaboration.rcp";
import { FileManager } from "../tools/FileManager";
import { fileIo } from "@kit.CoreFileKit";
import { ActivityListBean } from "../bean/api/ActivityListBean";
import { ResponseData } from "../bean/api/ResponseData";
import { RcpUtils } from "./RcpUtils";
import { ActivityRequestBean } from "../bean/api/ActivityRequestBean";
import { ApiName } from "./ApiName";

/**
 * 接口管理类
 * Created by zhouL on 2025/10/13.
 */
export class ApiManager {
  private constructor() {
  }

  /** 创建接口管理对象 */
  public static create(): ApiManager {
    return new ApiManager()
  }

  /**
   * 获取待办列表
   * @param context 上下文
   * @param isSuccess 是否成功返回数据
   */
  public getTodoList(context: Context | undefined, isSuccess: boolean = true): Promise<ResponseBean<Array<TodoBean>>> {
    return new Promise<ResponseBean<Array<TodoBean>>>((resolve, reject) => {
      setTimeout(() => {
        try {
          const json = ResourceUtils.getRawFileContentStrSync(context, 'DefaultTodoTasks.json')
          if (!isSuccess || json === null) {
            reject(new Error("获取本地数据失败"))
            return
          }
          const list = JsonUtils.jsonToBean<Array<TodoBean>>(json)
          const responseBean = new ResponseBean<Array<TodoBean>>()
          responseBean.code = list === null ? ResponseBean.Fail : ResponseBean.SUCCESS
          responseBean.data = list
          responseBean.msg = list === null ? "数据解析错误" : "获取成功"
          resolve(responseBean)
        } catch (e) {
          if (e instanceof Error) {
            reject(e)
          }
        }
      }, 2000)
    })
  }

  /** 获取图片 */
  public getImg(): Promise<string> {
    const imgUrl =
      `https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/shouye/2025-07-10/954-kaifazheshequ-0805.jpeg`
    return RcpUtils.getInstance().get(imgUrl)
      .then((response: rcp.Response) => {
        const body = response.body
        if (body === undefined) {
          throw new Error(`接口返回数据为空`)
        }
        const filePath = FileManager.getInstance().getCacheFolderPath() + StringUtils.getFileNameByUrl(imgUrl)
        FileUtils.writeFile(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE, body)
        return FileUtils.getUri(filePath)
      })
  }

  /** 获取图片 */
  public postData(pageNo:number): Promise<ResponseData<ActivityListBean>> {
    const bean = new ActivityRequestBean()
    bean.pagestart =pageNo

    const apiName = ApiName.getActivityList
    const content: rcp.RequestContent = JsonUtils.beanToJson(bean)
    return RcpUtils.getInstance().postJsonBean<ResponseData<ActivityListBean>>(apiName, content)
      .then((response: ResponseData<ActivityListBean>) => {
        return ResponseData.copy(response)
      })
  }
}