import { preferences } from "@kit.ArkData";
import { deviceInfo } from "@kit.BasicServicesKit";
import { CoreConstants } from "../config/CoreConstants";

/**
 * Preferences工具类
 * Created by zhouL on 2025/7/14.
 */
export class PreferencesUtils {
  /** 存储文件名 */
  static readonly PREFERENCE_NAME: string = 'pr_data'
  /** 单例对象 */
  private static instance: PreferencesUtils | null = null

  private constructor() {
  }

  /** 获取单例 */
  public static getInstance(): PreferencesUtils {
    if (!PreferencesUtils.instance) {
      PreferencesUtils.instance = new PreferencesUtils();
    }
    return PreferencesUtils.instance;
  }

  /** Preferences对象 */
  private preferences: preferences.Preferences | null = null

  /**
   * 初始化
   * @param context 上下文
   * @param preferenceName 存储文件名
   */
  public init(context: Context | undefined | null, preferenceName: string = PreferencesUtils.PREFERENCE_NAME) {
    if (this.preferences === null) {
      this.preferences = preferences.getPreferencesSync(context, { name: preferenceName });
    }
  }

  /**
   * 删除缓存文件
   * @param context 上下文
   * @param preferenceName 存储文件名
   */
  public async deletePreferences(context: Context | undefined | null, preferenceName: string = PreferencesUtils.PREFERENCE_NAME) {
    if (this.preferences !== null) {
      await preferences.deletePreferences(context, { name: preferenceName })
    }
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
  public async put(key: string, value: preferences.ValueType): Promise<void> {
    await this.preferences?.put(key, value)
    await this.preferences?.flush()
  }

  /**
   * 获取数据
   * @param key 键
   * @param defValue 默认值
   */
  public getSync<T extends preferences.ValueType>(key: string, defValue: T): T {
    return (this.preferences?.getSync(key, defValue) ?? defValue).valueOf() as T
  }

  /**
   * 异步获取数据
   * @param key 键
   * @param value 默认值
   */
  public async get<T extends preferences.ValueType>(key: string, defValue: T): Promise<T> {
    if (this.preferences === null) {
      return Promise.resolve(defValue)
    }
    return this.preferences.get(key, defValue)
      .then(value => {
        return value as T
      })
  }

  /**
   * 获取全部数据
   */
  public getAllSync(): preferences.ValueType {
    return this.preferences?.getAllSync() ?? new Object()
  }

  /**
   * 异步获取全部数据
   */
  public async getAll(): Promise<preferences.ValueType> {
    return this.preferences?.getAll() ?? new Promise<preferences.ValueType>((resolve) => {
      resolve(new Object())
    })
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
  public async has(key: string): Promise<boolean> {
    return this.preferences?.has(key) ?? new Promise<boolean>((resolve) => {
      resolve(false)
    })
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
  public async delete(key: string): Promise<void> {
    return this.preferences?.delete(key) ?? new Promise<void>((resolve) => {
      resolve()
    })
  }

  /**
   * 清除数据
   */
  public clearSync() {
    this.preferences?.clearSync()
  }

  /**
   * 异步清除数据
   */
  public async clear(): Promise<void> {
    return this.preferences?.clear() ?? new Promise<void>((resolve) => {
      resolve()
    })
  }

  /**
   * 订阅数据变更
   * @param observer 回调函数
   */
  public onChange(observer: (key: string) => void) {
    this.preferences?.on('change', observer);
  }

  /**
   * 取消订阅数据变更
   * @param observer 回调函数
   */
  public offChange(observer: (key: string) => void) {
    this.preferences?.off('change', observer);
  }

  /**
   * 精确订阅数据变更
   * @param keys 键数组
   * @param observer 回调函数
   */
  public onDataChange(keys: string | Array<string>, observer: (data: Record<string, preferences.ValueType>) => void) {
    if (typeof keys === 'string') {
      keys = [keys]
    }
    this.preferences?.on('dataChange', keys, observer);
  }

  /**
   * 取消精确订阅数据变更
   * @param keys 键数组
   * @param observer 回调函数
   */
  public offDataChange(keys: string | Array<string>, observer: (data: Record<string, preferences.ValueType>) => void) {
    if (typeof keys === 'string') {
      keys = [keys]
    }
    this.preferences?.off('dataChange', keys, observer);
  }
}

