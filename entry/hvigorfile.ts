import { hapTasks } from '@ohos/hvigor-ohos-plugin';
import { appPlugin } from "@hadss/hmrouter-plugin";

export default {
  system: hapTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: [appPlugin({ ignoreModuleNames: [] })]       /* Custom plugin to extend the functionality of Hvigor. */
}