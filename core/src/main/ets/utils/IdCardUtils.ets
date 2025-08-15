import { DateUtils } from "./DateUtils"
import { CoreConstants } from "../config/CoreConstants"

/**
 * 身份证工具类
 * Created by zhouL on 2025/8/15.
 */
export class IdCardUtils {
  /** 每位加权因子 */
  private static readonly POWER = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
  /** 省份代码 */
  private static readonly PROVINCE: Record<string, string> = {
    "11": "北京",
    "12": "天津",
    "13": "河北",
    "14": "山西",
    "15": "内蒙古",
    "21": "辽宁",
    "22": "吉林",
    "23": "黑龙江",
    "31": "上海",
    "32": "江苏",
    "33": "浙江",
    "34": "安徽",
    "35": "福建",
    "36": "江西",
    "37": "山东",
    "41": "河南",
    "42": "湖北",
    "43": "湖南",
    "44": "广东",
    "45": "广西",
    "46": "海南",
    "50": "重庆",
    "51": "四川",
    "52": "贵州",
    "53": "云南",
    "54": "西藏",
    "61": "陕西",
    "62": "甘肃",
    "63": "青海",
    "64": "宁夏",
    "65": "新疆",
    "71": "台湾",
    "81": "香港",
    "82": "澳门",
    "91": "国外"
  }

  /** 验证18位身份证号[idCard]是否合法 */
  public static validateIdCard(idCard: string | undefined | null): Boolean {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return false
    }
    if (idCard.length != 18) {
      return false
    }
    const code17 = idCard.substring(0, 17) // 取出前17位
    if (!IdCardUtils.isNum(code17)) { //前17位存在非数字
      return false
    }
    if (!IdCardUtils.isProvinceExist(idCard)) { // 判断省份是否存在
      return false
    }
    if (!IdCardUtils.validateBirth(idCard)) {// 判断日期是否存在
      return false
    }
    // val validationCode = getCheckCode18(getPowerSum(converCharToInt(code17.toCharArray())))
    // return validationCode.isNotEmpty() && validationCode.equals(idCard.subSequence(17, 18).toString(), true)
    return true
  }

  /**
   * 校验文本是否是纯数字
   * @param str 字符串
   */
  private static isNum(str: string): boolean {
    const regex = new RegExp('^[0-9]*$');
    return str.length > 0 && regex.test(str);
  }

  /**
   * 身份证的省份是否存在
   * @param idCard 身份证号
   */
   private static isProvinceExist(idCard: string): boolean {
    return IdCardUtils.PROVINCE[idCard.substring(0, 2)] !== undefined
  }

  /**
   * 校验身份证的出生日期是否正确
   * @param idCard 身份证号
   */
   private static validateBirth(idCard: string): boolean {
     if (idCard.length < 14) {
       return false
     }
     const birth = idCard.substring(6, 14)
     const date = DateUtils.parse(CoreConstants.DateFormat.TYPE_5, birth)

     return false
  }


//    /** 校验身份证[idCard]的出生日期是否正确 */
  //     private fun validateBirth(idCard: String): Boolean {
  //         if (idCard.isEmpty() || idCard.length < 14) {
  //             return false
  //         }
  //         val birth = idCard.substring(6, 14)
  //         val date = DateUtils.parseFormatDate(DateUtils.TYPE_5, birth) ?: return false
  //         val dateStr = DateUtils.getFormatString(DateUtils.TYPE_5, date)
  //         return dateStr == birth
  //     }

}
