import { CoreConstants, DateUtils, FileUtils, JsonUtils, StringUtils } from "@lodz/pandora";
import { ResponseBean } from "../bean/base/ResponseBean";
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
   * 获取本地数据
   * @param isSuccess 是否成功返回数据
   */
  public getLocalResult(isSuccess: boolean = true): Promise<ResponseBean<string>> {
    return new Promise<ResponseBean<string>>((resolve, reject) => {
      setTimeout(() => {
        const responseBean = new ResponseBean<string>()
        responseBean.code = isSuccess ? ResponseBean.SUCCESS : ResponseBean.Fail
        responseBean.data = isSuccess ? DateUtils.getCurrentFormatString(CoreConstants.DateFormat.TYPE_10) : ""
        responseBean.msg = isSuccess ? "获取成功" : "数据解析错误"
        resolve(responseBean)
      }, 1500)
    })
  }

  /** 获取图片 */
  public getImg(): Promise<string> {
    const imgUrl =
      `https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/shouye/2025-07-10/954-kaifazheshequ-0805.jpeg`
    return RcpUtils.get().get(imgUrl)
      .then((response: rcp.Response) => {
        const body = response.body
        if (body === undefined) {
          throw new Error(`接口返回数据为空`)
        }
        const filePath = FileManager.get().getCacheFolderPath() + StringUtils.getFileNameByUrl(imgUrl)
        FileUtils.writeFile(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE, body)
        return FileUtils.getUri(filePath)
      })
  }

  /**
   * 获取活动列表
   * @param pageNo 页码
   */
  public getActivityList(pageNo: number): Promise<ResponseData<ActivityListBean>> {
    const bean = new ActivityRequestBean()
    bean.pagestart = pageNo

    const apiName = ApiName.getActivityList
    const content: rcp.RequestContent = JsonUtils.beanToJson(bean)
    return RcpUtils.get().postJsonBean<ResponseData<ActivityListBean>>(apiName, content)
      .then((response: ResponseData<ActivityListBean>) => {
        return ResponseData.copy(response)
      })
  }
}