import { PermissionResult } from "./PermissionResult"

/**
 * 授权结果监听器
 * Created by zhouL on 2025/9/17.
 */
export interface PermissionListener {
  /** 全部授权回调 */
  onAllGranted: () => void
  /** 授权失败回调 */
  onDenied: (results: PermissionResult[]) => void
}