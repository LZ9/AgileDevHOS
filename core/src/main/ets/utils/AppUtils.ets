import { bundleManager } from "@kit.AbilityKit";

/**
 * app工具类
 * Created by zhouL on 2025/7/14.
 */
export class AppUtils {
  /**
   * 获取page里的上下文
   * @param com page对象
   */
  public static getContext(com: BaseCustomComponent): Context | undefined {
    return com.getUIContext().getHostContext();
  }

  /**
   * 是否定义
   * @param obj 对象
   */
  public static isDefined(obj: object | undefined | null): boolean {
    return obj !== undefined && obj !== null;
  }

  /** 获取当前应用信息 */
  public static getBundleInfoSync(): bundleManager.BundleInfo {
    return bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
  }

  /** 获取应用版本值 */
  public static getVersionCode(): number {
    return AppUtils.getBundleInfoSync().versionCode;
  }

  /** 获取应用版本号 */
  public static getVersionName(): string {
    return AppUtils.getBundleInfoSync().versionName;
  }
}
