import { DataError, JsonUtils, ResourceUtils } from "@lodz/pandora";
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
            reject(new DataError(ResponseBean.createFail<Array<TodoBean>>("获取本地数据失败"), "获取本地数据失败"))
            return
          }
          const list = JsonUtils.jsonToBean<Array<TodoBean>>(json)
          if (list === null) {
            reject(new DataError(ResponseBean.createFail<Array<TodoBean>>("数据解析错误"), "数据解析错误"))
            return
          }
          resolve(ResponseBean.createSuccess<Array<TodoBean>>(list))
        } catch (e) {
          if (e instanceof Error) {
            reject(e)
          }
        }
      }, 1000)
    })
  }
}
