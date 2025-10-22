import { rcp } from "@kit.RemoteCommunicationKit"
import { JsonUtils } from "@lodz/pandora"
import { UrlConfig } from "../config/UrlConfig"
import { RequestInterceptor } from "./RequestInterceptor"

/**
 * RCP网络请求工具类
 * Created by zhouL on 2025/8/11.
 */
export class RcpUtils {
  /** 单例对象 */
  private static instance: RcpUtils | null = null

  /** 获取单例 */
  public static getInstance(): RcpUtils {
    if (!RcpUtils.instance) {
      RcpUtils.instance = new RcpUtils()
    }
    return RcpUtils.instance
  }

  /** Session对象 */
  private rcpSession: rcp.Session

  private constructor() {
    this.rcpSession = rcp.createSession({
      interceptors: [new RequestInterceptor()],
      baseAddress: UrlConfig.BASE_URL,
      requestConfiguration: {
        transfer: {
          autoRedirect: true,
          timeout: {
            connectMs: 120000, //连接超时时间
            transferMs: 120000, //数据传输超时时间
            inactivityMs: 120000//无响应超时时间
          },
          assumesHTTP3Capable: true,
          pathPreference: "auto",
          serviceType: "default",
          maxAutoRedirects: 50,
          pausePolicy: {}
        }
      },
      cookies: {},
      sessionListener: {},
      connectionConfiguration: {
        maxConnectionsPerHost: 10, //Session中单个主机最大的并发连接数（默认是6）
        maxTotalConnections: 64, //Session中最大的同时连接总数（默认是64）
      }
    })
  }

  /**
   * 配置Session
   * @param session Session对象
   */
  public configSession(session: rcp.Session): void {
    this.rcpSession = session
  }

  /** 释放资源 */
  public release() {
    this.rcpSession.close()
  }

  /**
   * get请求
   * @param url 请求地址
   * @param headers 请求头
   */
  public get(url: string, headers?: Record<string, string>): Promise<rcp.Response> {
    const request = new rcp.Request(url, "GET")
    request.headers = headers
    return this.fetch(request)
  }

  /**
   * get请求
   * @param url 请求地址
   * @param headers 请求头
   */
  public getJsonBean<T>(url: string, headers?: Record<string, string>): Promise<T> {
    const request = new rcp.Request(url, "GET")
    request.headers = headers
    return this.fetchJsonBean(request)
  }

  /**
   * post请求
   * @param url 请求地址
   * @param content 请求内容
   * @param headers 请求头
   */
  public post(url: string, content?: rcp.RequestContent, headers?: Record<string, string>): Promise<rcp.Response> {
    const request = new rcp.Request(url, "POST")
    request.content = content
    request.headers = headers
    return this.fetch(request)
  }

  /**
   * post请求
   * @param url 请求地址
   * @param content 请求内容
   * @param headers 请求头
   */
  public postJsonBean<T>(url: string, content?: rcp.RequestContent, headers?: Record<string, string>): Promise<T> {
    const request = new rcp.Request(url, "POST")
    request.content = content
    request.headers = headers
    return this.fetchJsonBean(request)
  }

  /**
   * 数据请求
   * @param request 请求对象
   */
  public fetchJsonBean<T>(request: rcp.Request): Promise<T> {
    return this.fetch(request)
      .then((response: rcp.Response) => {
        const json = response.toString()
        if (json === null) {
          throw new Error(`接口数据内容为空`)
        }
        const bean = JsonUtils.jsonToBean<T>(json)
        if (bean === null) {
          throw new Error(`接口数据解析失败`)
        }
        return bean
      })
  }

  /**
   * 数据请求
   * @param request 请求对象
   */
  public fetch(request: rcp.Request): Promise<rcp.Response> {
    return this.rcpSession.fetch(request)
      .then((resp: rcp.Response) => {
        if (resp.statusCode === 200) {
          if (resp.body === undefined) {
            throw new Error(`接口数据内容为空`)
          }
          return resp
        }
        throw new Error(`请求失败，状态码：${resp.statusCode}，错误信息：${resp.reasonPhrase}`)
      })
  }
}
