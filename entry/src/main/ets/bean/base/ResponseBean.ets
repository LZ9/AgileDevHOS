import { ResponseContract } from "@lodz/pandora"
import { PageBean } from "./PageBean"

/**
 * 数据包裹层
 * Created by zhouL on 2025/7/16.
 */
export class ResponseBean<T> extends ResponseContract {

  /** 失败 */
  public static readonly Fail = 500
  /** 成功 */
  public static readonly SUCCESS = 200
  /** 返回提示信息 */
  public msg: string = "数据接口异常，请稍后再试"
  /** 本次接口请求返回的状态 */
  public code: number = ResponseBean.Fail
  /** 数据对象 */
  public data?: T | null | undefined
  /** 分页数据对象 */
  public page?: PageBean | null | undefined

  public valueSuccess(): boolean {
    return this.code === ResponseBean.SUCCESS
  }

  public valueMsg(): string {
    return this.msg
  }

  public valueCode(): number {
    return this.code
  }

  /**
   * 复制数据
   * @param response 源数据
   */
  public static copy<T>(response: ResponseBean<T>): ResponseBean<T> {
    const bean = new ResponseBean<T>()
    bean.code = response.code
    bean.msg = response.msg
    bean.data = response.data
    bean.page = response.page
    return bean
  }

  /**
   * 创建返回成功的数据实体
   * @param data 数据
   * @param msg 提示信息
   */
  public static createSuccess<T>(data?: T, msg: string = "调用成功"): ResponseBean<T> {
    const responseBean = new ResponseBean<T>()
    responseBean.code = ResponseBean.SUCCESS
    responseBean.msg = msg
    responseBean.data = data
    return responseBean
  }

  /**
   * 创建返回失败的数据实体
   * @param msg 提示信息
   */
  public static createFail<T>(msg: string = "调用失败"): ResponseBean<T> {
    const responseBean = new ResponseBean<T>()
    responseBean.code = ResponseBean.Fail
    responseBean.msg = msg
    return responseBean
  }
}