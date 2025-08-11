import { rcp } from "@kit.RemoteCommunicationKit"

/**
 * RCP网络请求工具类
 * Created by zhouL on 2025/8/11.
 */
export class RcpUtils {
  rcpSession: rcp.Session

  private constructor() {
    this.rcpSession = rcp.createSession()
  }

  public static create(): RcpUtils {
    return new RcpUtils()
  }

  public get(url: string): Promise<rcp.Response> {
    return this.rcpSession.get(url)
  }

}
