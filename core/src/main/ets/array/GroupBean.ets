import { Groupable } from "./Groupable"

/**
 * 分组数据
 * Created by zhouL on 2025/10/9.
 */
export class GroupBean<T extends Groupable> {
  /** 索引标题 */
  public indexStr: string = ""
  /** 数据 */
  public list: T[] = []
}