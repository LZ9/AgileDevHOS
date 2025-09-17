import { abilityAccessCtrl, PermissionRequestResult } from "@kit.AbilityKit"

/**
 * 授权结果
 * Created by zhouL on 2025/9/17.
 */
export class PermissionResult {
  /** 已授权 */
  public static readonly GRANTED = 0
  /** 弹框请求被用户拒绝 */
  public static readonly DENIED_SHOW_DIALOG = 1
  /** 无法再弹框请求，需要用户在“设置”中手动修改 */
  public static readonly DENIED_NO_DIALOG = 2
  /** 授权请求异常 */
  public static readonly DENIED_ERROR = 3


  /** 目标权限 */
  public permissions: string = ""
  /**
   * 授权结果
   * -1 未授权：dialogShownResults为true表示用户首次申请，dialogShownResults为false，表示权限已设置，无需弹窗，需要用户在“设置”中修改
   * 0 已授权
   * 2 未授权：请求无效，具体看errorReasons
   */
  public authResults: number = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED
  /** 有无弹窗提醒用户 */
  public dialogShownResults?: boolean
  /**
   * 错误原因
   * 0 本次申请合法
   * 1 权限名非法
   * 2 权限未声明
   * 3 不满足对应权限的申请条件，请参考权限列表中具体权限的说明。当前仅位置权限涉及
   * 4 用户未同意隐私声明
   * 5 该权限不支持通过权限弹窗进行申请
   * 6 该权限已被系统策略强制管控，无法通过权限弹窗申请
   * 12 服务异常
   *
   */
  public errorReasons?: number

  /** 获取授权结果类型 */
  public getResultType(): number {
    if (this.authResults === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      return PermissionResult.GRANTED
    }
    if (this.authResults === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      if (this.dialogShownResults !== undefined) {
        return this.dialogShownResults ? PermissionResult.DENIED_SHOW_DIALOG : PermissionResult.DENIED_NO_DIALOG
      }
    }
    return PermissionResult.DENIED_ERROR
  }

  /** 转换权限请求结果对象 */
  public static copy(result: PermissionRequestResult): Array<PermissionResult> {
    const list: PermissionResult[] = []
    for (let i = 0; i < result.permissions.length; i++) {
      const bean = new PermissionResult()
      bean.permissions = result.permissions[i]
      bean.authResults = result.authResults[i]
      if (result.dialogShownResults !== undefined) {
        bean.dialogShownResults = result.dialogShownResults[i]
      }
      if (result.errorReasons !== undefined) {
        bean.errorReasons = result.errorReasons[i]
      }
      list.push(bean)
    }
    return list
  }
}