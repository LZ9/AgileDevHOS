import emitter from "@ohos.events.emitter"

/**
 * 事件总线
 * Created by zhouL on 2025/10/29.
 */
export class EventBus {

  private constructor() {
  }

  public static get(): EventBus {
    return new EventBus()
  }

  /**
   * 订阅事件
   * @param id 事件编号
   * @param callback 订阅回调
   * @param priority 优先级，默认emitter.EventPriority.IMMEDIATE
   */
  public register(id: number, callback: (event: emitter.EventData) => void, priority?: emitter.EventPriority) {
    emitter.on({
      eventId: id,
      priority: priority ?? emitter.EventPriority.IMMEDIATE
    }, callback)
  }

  /**
   * 单次订阅指定的事件，在接收到该事件且执行完对应的回调函数后，自动取消订阅
   * @param id 事件编号
   * @param callback 订阅回调
   * @param priority 优先级，默认emitter.EventPriority.IMMEDIATE
   */
  public registerOnce(id: number, callback: (event: emitter.EventData) => void, priority?: emitter.EventPriority) {
    emitter.once({
      eventId: id,
      priority: priority ?? emitter.EventPriority.IMMEDIATE
    }, callback)
  }

  /**
   * 取消事件订阅
   * @param id 事件编号
   */
  public unregister(id: number) {
    emitter.off(id)
  }

  /**
   * 发送事件
   * @param id 事件编号
   * @param data  数据
   * @param priority 优先级，默认emitter.EventPriority.IMMEDIATE
   */
  public post(id: number, data?: Object, priority?: emitter.EventPriority) {
    emitter.emit(
      {
        eventId: id,
        priority: priority ?? emitter.EventPriority.IMMEDIATE
      },
      {
        data: data
      })
  }

  /**
   * 获取指定事件的订阅数
   * @param id 事件编号
   */
  public getListenerCount(id: number): number {
    return emitter.getListenerCount(id)
  }
}