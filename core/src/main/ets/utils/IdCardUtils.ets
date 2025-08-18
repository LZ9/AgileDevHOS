import { DateUtils } from "./DateUtils"
import { CoreConstants } from "../config/CoreConstants"
import { StringUtils } from "./StringUtils"

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
    if (!IdCardUtils.validateBirth(idCard)) { // 判断日期是否存在
      return false
    }
    const validationCode = IdCardUtils.getCheckCode18(IdCardUtils.getPowerSum(IdCardUtils.convertCharToInt(code17)))
    return validationCode.length > 0 && StringUtils.equalsIgnoreCase(validationCode, idCard.substring(17, 18))
  }

  /**
   * 获取17位待补全的身份证号的校验位
   * @param idCard 前17位身份证号
   */
  public static getValidationCode(code17: string | undefined | null): string {
    if (code17 === undefined || code17 === null) {
      return ""
    }
    if (code17.length !== 17) {
      return ""
    }
    if (!IdCardUtils.isNum(code17)) { //前17位存在非数字
      return ""
    }
    return IdCardUtils.getCheckCode18(IdCardUtils.getPowerSum(IdCardUtils.convertCharToInt(code17)))
  }

  /**
   * 获取身份证的性别代码（0非身份证 1男 2女）
   * @param idCard 身份证号
   */
  public static getSexCode(idCard: string | undefined | null): number {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return 0
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return 0
    }
    const sex = parseInt(idCard.substring(16, 17))
    return sex % 2 != 0 ? 1 : 2
  }

  /**
   * 获取身份证的性别（男 女）
   * @param idCard 身份证号
   */
  public static getSexStr(idCard: string | undefined | null): string {
    switch (IdCardUtils.getSexCode(idCard)){
      case 1: return "男"
      case 2: return "女"
      default: return ""
    }
  }

  /**
   * 根据日期格式从身份证获取出生年月
   * @param idCard 身份证号
   * @param dateFormat 日期格式（默认格式yyyyMMdd）
   */
  public static getBirth(idCard: string | undefined | null, dateFormat: string = CoreConstants.DateFormat.TYPE_5): string {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return ""
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return ""
    }
    if (dateFormat.length === 0) {
      return ""
    }
    const original = idCard.substring(6, 14)
    return StringUtils.equalsIgnoreCase(dateFormat, CoreConstants.DateFormat.TYPE_5) ?
      original : DateUtils.changeFormatString(CoreConstants.DateFormat.TYPE_5, dateFormat, original)
  }

  /**
   * 从身份证获取年
   * @param idCard 身份证号
   */
  public static getYear(idCard: string | undefined | null): string {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return ""
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return ""
    }
    return idCard.substring(6, 10)
  }

  /**
   * 从身份证获取月
   * @param idCard 身份证号
   */
  public static getMonth(idCard: string | undefined | null): string {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return ""
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return ""
    }
    return idCard.substring(10, 12)
  }

  /**
   * 从身份证获取日
   * @param idCard 身份证号
   */
  public static getDay(idCard: string | undefined | null): string {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return ""
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return ""
    }
    return idCard.substring(12, 14)
  }

  /**
   * 从身份证获取年龄
   * @param idCard 身份证号
   */
  public static getAge(idCard: string | undefined | null): number {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return 0
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return 0
    }
    let year = new Date().getFullYear()
    return year - parseInt(IdCardUtils.getYear(idCard))
  }

  /**
   * 从身份证获取户籍省份
   * @param idCard 身份证号
   */
  public static getProvince(idCard: string | undefined | null): string {
    if (idCard === undefined || idCard === null || idCard.length === 0) {
      return ""
    }
    if (!IdCardUtils.validateIdCard(idCard)) {
      return ""
    }
    return IdCardUtils.PROVINCE[idCard.substring(0, 2)] ?? ""
  }



  //
  //     /**  */
  //     @JvmStatic
  //     fun getProvince(idCard: String): String {
  //         if (!validateIdCard(idCard)) {
  //             return ""
  //         }
  //         val provinceNum = idCard.substring(0, 2)
  //         val map = getProvinceMap()
  //         return map[provinceNum] ?: ""
  //     }





  /**
   * 校验文本是否是纯数字
   * @param str 字符串
   */
  private static isNum(str: string): boolean {
    const regex = new RegExp('^[0-9]*$')
    return str.length > 0 && regex.test(str)
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
    const dateStr = DateUtils.getFormatString(CoreConstants.DateFormat.TYPE_5, date)
    return dateStr === birth
  }


  /**
   * 将身份证前17位字符串转换成数字数组
   * @param str 字符串
   */
  private static convertCharToInt(str: string): Array<number> {
    let array: Array<number> = []
    for (let i = 0; i < str.length; i++) {
      array.push(parseInt(str.charAt(i)))
    }
    return array
  }

  /**
   * 将身份证的每位和对应位的加权因子相乘之后，再得到和值
   * @param array 身份证前17位数组
   */
  private static getPowerSum(array: Array<number>): number {
    let sum = 0
    if (IdCardUtils.POWER.length === array.length) {
      for (let i = 0; i < array.length; i++) {
        for (let j = 0; j < IdCardUtils.POWER.length; j++) {
          if (i === j) {
            sum += array[i] * IdCardUtils.POWER[j]
          }
        }
      }
    }
    return sum
  }

  /**
   * 将power和身份证前17位的和与11取模获得余数进行校验码判断
   * @param sum 身份证前17位的和
   */
  private static getCheckCode18(sum: number): string {
    switch (sum % 11) {
      case 10: return "2"
      case 9: return "3"
      case 8: return "4"
      case 7: return "5"
      case 6: return "6"
      case 5: return "7"
      case 4: return "8"
      case 3: return "9"
      case 2: return "x"
      case 1: return "0"
      case 0: return "1"
      default: return ""
    }
  }
}
