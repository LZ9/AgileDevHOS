import { ProgressDialogAgent } from "../../components/progress/ProgressDialogAgent"
import { ProgressDialogVm } from "../../components/progress/ProgressDialogVm"
import { DataError } from "./DataError"
import { Disposable } from "./Disposable"
import { Observer } from "./Observer"
import { ProgressObserver } from "./ProgressObserver"
import { ResponseContract } from "./ResponseContract"
import { ComponentContent, promptAction } from "@kit.ArkUI"

/**
 * Promise扩展
 * Created by zhouL on 2025/7/29.
 */
export class PromiseAgent<T extends Object> implements Disposable {
  /** 外部Promise代码块 */
  private block?: (controller: Disposable) => Promise<T> | undefined
  /** 是否终止 */
  private isStop: boolean = false

  private constructor() {}

  /** 创建Promise代理 */
  public static create<T extends Object>(t?: T): PromiseAgent<T> {
    return new PromiseAgent<T>()
  }

  /**
   * 创建Promise对象
   * @param t 数据
   */
  public static just<T>(t?: T): Promise<T | undefined> {
    return Promise.resolve(t)
  }

  /**
   * 执行外部Promise代码块
   * @param block 代码块
   */
  public then(block: (controller: Disposable) => Promise<T>): PromiseAgent<T> {
    this.block = block
    return this
  }

  /** 任务是否终止 */
  public isDisposed(): boolean {
    return this.isStop
  }

  /** 终止任务 */
  public dispose(): void {
    this.isStop = true
  }

  /**
   * 订阅Promise结果（对默认加载框样进行配置）
   * @param context 上下文
   * @param observer 观察者
   * @param agent 配置后的加载框代理
   */
  public subscribePgAgent(context: UIContext, observer: ProgressObserver<T>, agent: ProgressDialogAgent): Disposable {
    const bean = agent.build(context)
    return this.subscribePg<ProgressDialogVm>(context, observer, bean.content, bean.options)
  }

  /**
   * 订阅Promise结果（使用默认加载框样式）
   * @param context 上下文
   * @param observer 观察者
   * @param autoCancel 是否允许用户手动取消加载框（默认不允许）
   * @param tips 加载提示语（默认展示加载中）
   */
  public subscribePgDef(context: UIContext, observer: ProgressObserver<T>, autoCancel?: boolean, tips?: string | Resource): Disposable {
    const vm = new ProgressDialogVm()
    vm.textVm.content = tips
    const bean = ProgressDialogAgent.create().setAutoCancel(autoCancel ?? false).setViewModel(vm).build(context)
    return this.subscribePg<ProgressDialogVm>(context, observer, bean.content, bean.options)
  }

  /**
   * 订阅Promise结果（自定义加载框）
   * @param context 上下文
   * @param observer 观察者
   * @param content 组件内容
   * @param options 参数
   */
  public subscribePg<E extends object>(context: UIContext, observer: ProgressObserver<T>, content: ComponentContent<E>, options: promptAction.BaseDialogOptions): Disposable {
    options.onWillDismiss = (dismissDialogAction: DismissDialogAction) => { // 处理加载框取消交互逻辑
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) { // 点击空白处不响应
        return
      }
      if (!options.autoCancel) { //不允许用户手动取消加载框
        return
      }
      this.dispose() //如果用户关闭加载框则终止订阅
      dismissDialogAction.dismiss()
      if (observer && observer.onPgCancel) {
        observer.onPgCancel()
      }
    }

    return this.subscribe({
      onSubscribe: () => {
        context.getPromptAction().openCustomDialog(content, options)
        if (observer && observer.onSubscribe) {
          observer.onSubscribe()
        }
      },
      onNext: (data: T) => {
        if (observer) {
          observer.onNext(data)
        }
      },
      onError: (e: DataError<T>) => {
        if (observer) {
          observer.onError(e)
        }
      },
      onFinally: () => {
        context.getPromptAction().closeCustomDialog(content)
        if (observer && observer.onFinally) {
          observer.onFinally()
        }
      }
    })
  }

  /**
   * 订阅Promise结果（返回生命周期控制器）
   * @param observer 观察者
   */
  public subscribe(observer?: Observer<T>): Disposable {
    PromiseAgent.just<T>()
      .then((t) => {
        if (observer && observer.onSubscribe) {
          observer.onSubscribe() //订阅前回调
        }
        return t
      })
      .then((t) => {
        if (this.block) {
          return this.block(this) // 执行自定义Promise
        }
        return PromiseAgent.just(t)
      })
      .then((t) => {
        if (this.isDisposed()) { //如果已终止就不再执行回调
          return
        }
        if (t === undefined) {
          if (observer && observer.onError) {
            observer.onError(new DataError<T>(0, t, new Error("返回数据为undefined")))
          }
          return
        }
        if (t instanceof ResponseContract) {
          if (!t.isSuccess()) { // 预判接口请求是否成功
            if (observer && observer.onError) {
              observer.onError(new DataError<T>(t.valueCode(), t, new Error(t.valueMsg())))
            }
            return
          }
        }
        if (observer) {
          observer.onNext(t) // 数据返回成功回调
        }
      })
      .catch((e: Error) => {
        if (this.isDisposed()) {
          return
        }
        if (observer && observer.onError) {
          let err = new DataError<T>(0, undefined, e)
          if (e instanceof DataError) {
            err = e
          }
          observer.onError(err) // 订阅报错回调
        }
      })
      .finally(() => {
        if (this.isDisposed()) {
          return
        }
        if (observer && observer.onFinally) {
          observer.onFinally() // 订阅结束回调
        }
      })
    return this
  }
}