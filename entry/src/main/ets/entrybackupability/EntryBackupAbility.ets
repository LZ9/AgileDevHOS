import { hilog } from '@kit.PerformanceAnalysisKit';
import { BackupExtensionAbility, BundleVersion } from '@kit.CoreFileKit';
import { PrintLog } from 'pandora'
import { Constants } from '../config/Constants';

//从HarmonyOS 4.x升级到HarmonyOS NEXT后，应用数据的转换和迁移
export default class EntryBackupAbility extends BackupExtensionAbility {
  async onBackup() {
    PrintLog.i(Constants.Log.TAG, 'onBackup ok');
    await Promise.resolve();
  }

  async onRestore(bundleVersion: BundleVersion) {
    PrintLog.i(Constants.Log.TAG, `onRestore ok ${JSON.stringify(bundleVersion)}`);
    //bundleVersion.name的前缀为“0.0.0.0”时，表示终端设备从HarmonyOS升级到HarmonyOS NEXT数据迁移场景
    if (bundleVersion.name.startsWith("0.0.0.0")){
      // 在此处实现终端设备从HarmonyOS 4.x升级到HarmonyOS NEXT后，应用数据的转换和迁移
      // 涉及异步操作请进行同步等待
      PrintLog.i(Constants.Log.TAG, `HarmonyOS to HarmonyOS NEXT scenario`);
    } else {
      // 在此处实现从HarmonyOS NEXT设备迁移到HarmonyOS NEXT设备后，应用数据的处理。无特殊要求，可以空实现
      // 涉及异步操作请进行同步等待
      PrintLog.i(Constants.Log.TAG, `Other scenario`);
    }
    await Promise.resolve();
  }
}