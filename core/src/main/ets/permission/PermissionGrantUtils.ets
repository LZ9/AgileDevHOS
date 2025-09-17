import { abilityAccessCtrl, bundleManager, PermissionRequestResult, Permissions } from '@kit.AbilityKit'
import { PermissionListener } from './PermissionListener'
import { PermissionResult } from './PermissionResult'

/**
 * 授权工具类
 * Created by zhouL on 2025/9/17.
 */
export class PermissionGrantUtils {
  /**
   * 核对权限状态
   * @param context 上下文
   * @param permissionName 权限名称
   */
  public static check(permissionName: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    const info = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    return abilityAccessCtrl.createAtManager().checkAccessToken(info.appInfo.accessTokenId, permissionName)
  }

  /**
   * 向用户请求授权
   * @param context 上下文
   * @param permissionList 权限列表
   */
  public static requestPermissionResult(context: Context | undefined, permissionList: Array<Permissions>): Promise<Array<PermissionResult>> {
    return abilityAccessCtrl.createAtManager().requestPermissionsFromUser(context, permissionList)
      .then((result: PermissionRequestResult) => {
        return PermissionResult.copy(result)
      })
  }

  /**
   * 向用户请求授权
   * @param context 上下文
   * @param permissionList 权限列表
   */
  public static requestPermission(context: Context | undefined, permissionList: Array<Permissions>): Promise<PermissionRequestResult> {
    return abilityAccessCtrl.createAtManager().requestPermissionsFromUser(context, permissionList)
  }

  /**
   * 自动判断权限并向用户申请
   * @param context 上下文
   * @param permissionList 权限列表
   * @param onAllGranted 全部授权回调
   * @param onDenied 授权失败回调
   */
  public static async auto(context: Context | undefined, permissionList: Array<Permissions>, listener: PermissionListener) {
    const checkResults: abilityAccessCtrl.GrantStatus[] = []
    for (let name of permissionList) {
      checkResults.push(await PermissionGrantUtils.check(name))
    }
    const needRequests: Permissions[] = []
    for (let i = 0; i < checkResults.length; i++) {
      if (checkResults[i] === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
        needRequests.push(permissionList[i])
      }
    }
    if (needRequests.length === 0) { // 所有权限都已授权
      listener.onAllGranted()
      return
    }
    const deniedList: PermissionResult[] = [] // 被拒绝的权限列表
    const resultList = await PermissionGrantUtils.requestPermissionResult(context, needRequests)
    for (let result of resultList) {
      if (result.getResultType() === PermissionResult.GRANTED) {
        continue
      }
      deniedList.push(result)
    }
    if (deniedList.length === 0) {
      listener.onAllGranted()
      return
    }
    listener.onDenied(deniedList)
  }


}