import { Groupable } from "./Groupable"
import { GroupBean } from "./GroupBean"

/**
 * 数组工具类
 * Created by zhouL on 2025/10/9.
 */
export class ArrayUtils {
  /**
   * 判断数组是否为空
   * @param array 数组
   */
  public static isEmpty<T>(array: T[] | null | undefined): boolean {
    return array === undefined || array === null || array.length === 0
  }

  /**
   * 根据索引对列表数据进行分组
   * @param array 列表数据
   * @param indexGroup 索引数据
   */
  public static group<T extends Groupable>(array: T[] | null | undefined, indexGroup: Array<string>): GroupBean<T>[] {
    const resultList: GroupBean<T>[] = []
    if (array === undefined || array === null || array.length === 0) {
      return resultList
    }
    for (let index of indexGroup) {
      const bean = new GroupBean<T>()
      bean.indexStr = index
      bean.list = []
      resultList.push(bean)
    }
    for (let item of array) {
      const index = item.getSortStr()
      for (let bean of resultList) {
        if (bean.indexStr === index) {
          bean.list.push(item)
          break
        }
      }
    }
    return resultList
  }

  /**
   * 根据索引对列表数据进行分组，筛选出有数据的索引列表
   * @param array 列表数据
   * @param indexGroup 索引数据
   */
  public static groupFilter<T extends Groupable>(array: T[] | null | undefined, indexGroup: Array<string>): GroupBean<T>[] {
    return ArrayUtils.group(array, indexGroup).filter(bean => bean.list.length > 0)
  }

}