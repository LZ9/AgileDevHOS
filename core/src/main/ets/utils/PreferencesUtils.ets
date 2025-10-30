import { preferences } from "@kit.ArkData"
import { deviceInfo } from "@kit.BasicServicesKit"
import { CoreConstants } from "../config/CoreConstants"

/**
 * Preferences工具类
 * Created by zhouL on 2025/7/14.
 */
export class PreferencesUtils {
  /** 单例对象 */
  private static instance: PreferencesUtils

  private constructor() {
  }

  /** 获取单例 */
  public static get(): PreferencesUtils {
    if (!PreferencesUtils.instance) {
      PreferencesUtils.instance = new PreferencesUtils()
    }
    return PreferencesUtils.instance
  }

  /** 存储文件名 */
  private static readonly PREFERENCE_NAME: string = 'pr_data'

  /** Preferences对象 */
  private preferences?: preferences.Preferences

  /**
   * 初始化
   * @param context 上下文
   * @param preferenceName 存储文件名
   */
  public init(context: Context | undefined | null, preferenceName: string = PreferencesUtils.PREFERENCE_NAME) {
    if (this.preferences !== undefined) {
      return
    }
    if (context === undefined || context === null) {
      return
    }
    this.preferences = preferences.getPreferencesSync(context, { name: preferenceName })
  }

  /**
   * 删除缓存文件
   * @param context 上下文
   * @param preferenceName 存储文件名
   */
  public deletePreferences(context: Context | undefined | null, preferenceName: string = PreferencesUtils.PREFERENCE_NAME): Promise<void> {
    return preferences.deletePreferences(context, { name: preferenceName })
  }

  /**
   * 存储数据
   * @param key 键
   * @param value 值
   */
  public putSync(key: string, value: preferences.ValueType) {
    this.preferences?.putSync(key, value)
    if (deviceInfo.sdkApiVersion >= CoreConstants.SdkApiVersion.VERSION_14) {
      this.preferences?.flushSync()
    } else {
      this.preferences?.flush()
    }
  }

  /**
   * 异步存储数据
   * @param key 键
   * @param value 值
   */
  public put(key: string, value: preferences.ValueType): Promise<void> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.put(key, value).then(() => p.flush())
  }

  /**
   * 获取数据
   * @param key 键
   * @param defValue 默认值
   */
  public getSync<T extends preferences.ValueType>(key: string, defValue: T): T {
    if (this.preferences === undefined) {
      return defValue
    }
    return this.preferences?.getSync(key, defValue).valueOf() as T
  }

  /**
   * 异步获取数据
   * @param key 键
   * @param value 默认值
   */
  public get<T extends preferences.ValueType>(key: string, defValue: T): Promise<T> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.get(key, defValue).then(value => { return value as T })
  }

  /** 获取全部数据 */
  public getAllSync(): Object | null{
    return this.preferences?.getAllSync() ?? null
  }

  /** 异步获取全部数据 */
  public getAll(): Promise<Object> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.getAll()
  }

  /** 获取全部数据的Key */
  public getAllKeysSync(): string[] {
    return Object.keys(this.preferences?.getAllSync() ?? [])
  }

  /** 异步获取全部数据的Key */
  public getAllKeys(): Promise<string[]> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.getAll().then(value => { return Object.keys(value) })
  }

  /**
   * key是否存在
   * @param key 键
   */
  public hasSync(key: string): boolean {
    return this.preferences?.hasSync(key) ?? false
  }

  /**
   * 异步判断key是否存在
   * @param key 键
   */
  public has(key: string): Promise<boolean> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.has(key)
  }

  /**
   * 删除key对应的值
   * @param key 键
   */
  public deleteSync(key: string) {
    this.preferences?.deleteSync(key)
  }

  /**
   * 异步删除key对应的值
   * @param key 键
   */
  public delete(key: string): Promise<void> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.delete(key)
  }

  /** 清除数据 */
  public clearSync() {
    this.preferences?.clearSync()
    if (deviceInfo.sdkApiVersion >= CoreConstants.SdkApiVersion.VERSION_14) {
      this.preferences?.flushSync()
    } else {
      this.preferences?.flush()
    }
  }

  /** 异步清除数据 */
  public clear(): Promise<void> {
    const p = this.preferences
    if (p === undefined) {
      return Promise.reject(new Error("未初始化"))
    }
    return p.clear().then(() => p.flush())
  }

  /**
   * 订阅数据变更
   * @param observer 回调函数
   */
  public onChange(callback: Callback<string>) {
    this.preferences?.on('change', callback)
  }

  /**
   * 取消订阅数据变更
   * @param observer 回调函数
   */
  public offChange(callback: Callback<string>) {
    this.preferences?.off('change', callback)
  }

  /**
   * 精确订阅数据变更
   * @param keys 键数组
   * @param observer 回调函数
   */
  public onDataChange(keys: string | Array<string>, callback: Callback<Record<string, preferences.ValueType>>) {
    if (typeof keys === 'string') {
      keys = [keys]
    }
    this.preferences?.on('dataChange', keys, callback)
  }

  /**
   * 取消精确订阅数据变更
   * @param keys 键数组
   * @param observer 回调函数
   */
  public offDataChange(keys: string | Array<string>, callback?: Callback<Record<string, preferences.ValueType>>) {
    if (typeof keys === 'string') {
      keys = [keys]
    }
    this.preferences?.off('dataChange', keys, callback)
  }
}

