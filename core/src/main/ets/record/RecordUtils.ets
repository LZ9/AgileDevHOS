import { RecordData } from "./RecordData";

/**
 * Record工具类
 * Created by zhouL on 2025/9/19.
 */
export class RecordUtils {

  /**
   * 转换Record为RecordData数组
   * @param record 数据对象
   */
  public static transformData<V>(record: Record<string | number, V>): RecordData<V>[] {
    const data: RecordData<V>[] = []
    Object.keys(record).forEach((key: string | number) => {
      data.push(new RecordData(key, record[key]))
    })
    return data
  }

  /**
   * 转换RecordData[]为Record
   * @param data 数据对象
   */
  public static transformRecord<V>(data: RecordData<V>[]): Record<string | number, V>{
    const record: Record<string | number, V> = {}
    for (let item of data) {
      record[item.key] = item.value
    }
    return record
  }

}