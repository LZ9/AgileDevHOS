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

  public isSuccess(): boolean {
    return this.code === ResponseBean.SUCCESS
  }

  public valueMsg(): string {
    return this.msg
  }

  public valueStatus(): string {
    return this.code.toString()
  }
  
  public static createSuccess<T>(data?: T, msg: string = "成功"): ResponseBean<T> {
    const responseBean = new ResponseBean<T>()
    responseBean.code = ResponseBean.SUCCESS
    responseBean.msg = msg
    responseBean.data = data
    return responseBean
  }

  public static createFail<T>(msg: string = "失败"): ResponseBean<T> {
    const responseBean = new ResponseBean<T>()
    responseBean.code = ResponseBean.Fail
    responseBean.msg = msg
    return responseBean
  }
}