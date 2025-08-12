import { rcp } from "@kit.RemoteCommunicationKit";
import { JsonUtils, PrintLog } from "@lodz/pandora";
import { Constants } from "../../config/Constants";

/**
 * 请求拦截器
 * Created by zhouL on 2025/8/12.
 */
export class RequestInterceptor implements rcp.Interceptor {
  intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    const request = context.request;
    this.logRequest(request)
    return next.handle(context)
      .then(response => {
        this.logResponse(response)
        return response
      })
  }

  /**
   * 打印请求日志
   * @param request 请求对象
   */
  private logRequest(request: rcp.Request) {
    const url = request.url.toString()
    PrintLog.i(Constants.Log.TAG_API, `[${this.getApiName(url)}] ----> ${url}`)
    PrintLog.i(Constants.Log.TAG_API, `[${this.getApiName(url)}] ----> ${JsonUtils.beanToJson(request.content)}`)
  }

  /**
   * 打印响应日志
   * @param response 响应对象
   */
  private logResponse(response: rcp.Response) {
    let log = "不打印非json的返回信息"
    const result = response.toString()
    if (result?.startsWith(`{`) || result?.startsWith(`[`)) {
      log = result
    }
    PrintLog.d(Constants.Log.TAG_API, `[${this.getApiName(response.request.url.toString())}] <--- ${log}`)
  }

  /**
   * 获取接口名称
   * @param url 路径
   */
  private getApiName(url: string): string {
    const parts = url.split('/')
    return parts[parts.length - 1]
  }
}
