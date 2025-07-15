import { ShowToastOptions } from "@kit.ArkUI";

/**
 * 提示工具类
 * Created by Admin on 2025/7/15.
 */
export class PromptUtils {



  
  public static showToast(context: UIContext, message: string,duration?: number,bottom?: string | number) {
    context.getPromptAction().showToast({ message:message,duration:duration,bottom:bottom,alignment: Alignment.Center  })
  }
}

// /**
//     message: string;
//      */
//     duration?: number;
//     bottom?: string | number;