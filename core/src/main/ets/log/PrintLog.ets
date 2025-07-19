import { hilog } from '@kit.PerformanceAnalysisKit'

/**
 * 日志打印工具
 * Created by zhouL on 2025/7/12.
 */
export class PrintLog {
  /** 日志开关 */
  private static isPrint: boolean = true
  /** 日志域 */
  private static domain = 0x0007

  /**
   * 是否打印日志
   * @param isPrint 日志开关
   */
  public static setPrint(isPrint: boolean) {
    PrintLog.isPrint = isPrint
  }

  /**
   * 设置服务域
   * @param domain 服务域，范围为 0x0 到 0xFFFF 的十六进制整数
   */
  public static setDomain(domain: number) {
    PrintLog.domain = domain
  }

  /**
   * 打印DEBUG类型日志
   * @param tag 日志标签
   * @param log 日志内容
   */
  public static d(tag: string, log: string | null | undefined) {
    if (PrintLog.isPrint) {
      PrintLog.logByType(hilog.LogLevel.DEBUG, tag, log)
    }
  }

  /**
   * 打印INFO类型日志
   * @param tag 日志标签
   * @param log 日志内容
   */
  public static i(tag: string, log: string | null | undefined) {
    if (PrintLog.isPrint) {
      PrintLog.logByType(hilog.LogLevel.INFO, tag, log)
    }
  }

  /**
   * 打印WARN类型日志
   * @param tag 日志标签
   * @param log 日志内容
   */
  public static w(tag: string, log: string | null | undefined) {
    if (PrintLog.isPrint) {
      PrintLog.logByType(hilog.LogLevel.WARN, tag, log)
    }
  }

  /**
   * 打印ERROR类型日志
   * @param tag 日志标签
   * @param log 日志内容
   */
  public static e(tag: string, log: string | null | undefined) {
    if (PrintLog.isPrint) {
      PrintLog.logByType(hilog.LogLevel.ERROR, tag, log)
    }
  }

  /**
   * 打印FATAL类型日志
   * @param tag 日志标签
   * @param log 日志内容
   */
  public static f(tag: string, log: string | null | undefined) {
    if (PrintLog.isPrint) {
      PrintLog.logByType(hilog.LogLevel.FATAL, tag, log)
    }
  }

  /**
   * 根据类型打印日志
   * @param type 日志类型
   * @param tag 日志标签
   * @param log 日志内容
   */
  private static logByType(type: hilog.LogLevel, tag: string, log: string | null | undefined) {
    switch (type) {
      case hilog.LogLevel.DEBUG:
        hilog.debug(PrintLog.domain, tag, '%{public}s', log ?? "null")
        break
      case hilog.LogLevel.INFO:
        hilog.info(PrintLog.domain, tag, '%{public}s', log ?? "null")
        break
      case hilog.LogLevel.WARN:
        hilog.warn(PrintLog.domain, tag, '%{public}s', log ?? "null")
        break
      case hilog.LogLevel.ERROR:
        hilog.error(PrintLog.domain, tag, '%{public}s', log ?? "null")
        break
      case hilog.LogLevel.FATAL:
        hilog.fatal(PrintLog.domain, tag, '%{public}s', log ?? "null")
        break
    }
  }
}