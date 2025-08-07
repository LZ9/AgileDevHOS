import { JsonUtils, ResourceUtils } from "@lodz/pandora";
import { ResponseBean } from "../bean/base/ResponseBean";
import { TodoBean } from "../bean/mvvm/TodoBean";

/**
 * 接口数据服务
 * Created by zhouL on 2025/7/29.
 */
export class ApiService {
  private constructor() {
  }

  public static create(): ApiService {
    return new ApiService();
  }

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
      }, 1000)
    })
  }
}
