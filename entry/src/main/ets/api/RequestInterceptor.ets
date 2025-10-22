import { rcp } from "@kit.RemoteCommunicationKit";
import { AppUtils, JsonUtils, PrintLog } from "@lodz/pandora";
import { Constants } from "../config/Constants";

/**
 * 请求拦截器
 * Created by zhouL on 2025/8/12.
 */
export class RequestInterceptor implements rcp.Interceptor {
  intercept(context: rcp.RequestContext, next: rcp.RequestHandler): Promise<rcp.Response> {
    const request = context.request;
    request.headers = this.assembleHeaders(request.headers)
    this.logRequest(request)
    return next.handle(context)
      .then(response => {
        this.logResponse(response)
        return response
      })
      .catch((e: Error) => {
        this.logError(e)
        return Promise.reject(e)
      })
  }

  /** 组装头信息 */
  private assembleHeaders(oldHeaders?: rcp.RequestHeaders): Record<string, string> {
    let headers: Record<string, string> = {}
    headers['Content-Type'] = 'application/json'
    headers['versionCode'] = AppUtils.getVersionCode().toString() //版本号
    headers['versionName'] = AppUtils.getVersionName().toString() //版本名称

    if (oldHeaders !== undefined) {
      Object.keys(oldHeaders).forEach((key: string) => {
        const value = oldHeaders[key]
        if (typeof value === "string") {
          headers[key] = value
        }
      })
    }
    return headers
  }

  /**
   * 打印请求日志
   * @param request 请求对象
   */
  private logRequest(request: rcp.Request) {
    const url = request.url.toString()
    PrintLog.i(Constants.Log.TAG_API, `[${this.getApiName(url)}] url ----> ${url}`)
    PrintLog.i(Constants.Log.TAG_API, `[${this.getApiName(url)}] headers ----> ${JsonUtils.beanToJson(request.headers)}`)
    PrintLog.i(Constants.Log.TAG_API, `[${this.getApiName(url)}] params ----> ${JsonUtils.beanToJson(request.content)}`)
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
    PrintLog.d(Constants.Log.TAG_API, `[${this.getApiName(response.request.url.toString())}] headers <--- ${JsonUtils.beanToJson(response.headers)}`)
    PrintLog.d(Constants.Log.TAG_API, `[${this.getApiName(response.request.url.toString())}] content <--- ${log}`)
  }

  /**
   * 打印异常日志
   * @param e 异常对象
   */
  private logError(e: Error) {
    PrintLog.d(Constants.Log.TAG_API, `[] <--- ${JsonUtils.beanToJson(e)}`)
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
