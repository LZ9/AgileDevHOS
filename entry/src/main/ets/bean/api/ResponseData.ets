import { ResponseContract } from "@lodz/pandora"

/**
 * 数据包裹层
 * Created by zhouL on 2025/8/11.
 */
export class ResponseData<T> extends ResponseContract {

  /** 成功 */
  public static readonly SUCCESS = `00000`

  public code: string = ""

  public value?: T | null | undefined

  public isSuccess(): boolean {
    return this.code === ResponseData.SUCCESS
  }

  public valueMsg(): string {
    return this.code === ResponseData.SUCCESS ? "请求成功" : "数据接口异常，请稍后再试"
  }

  public valueCode(): number {
    return this.isSuccess() ? 200 : 500
  }

  public static copy<T>(response: ResponseData<T>): ResponseData<T> {
    const bean = new ResponseData<T>()
    bean.code = response.code
    bean.value = response.value
    return bean
  }
}
