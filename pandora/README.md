# Pandora库
Pandora是基于鸿蒙开发的敏捷开发解决方案，里面包括了鸿蒙APP基础开发需要用到的大部分基类、控件和工具。
你可以直接引用Pandora进行上层UI和业务逻辑开发，或者从中抽取你需要模块代码支援你的工程

## 1.使用
### 项目地址
Github：[源码](https://github.com/LZ9/AgileDevHOS)

### 下载安装

```
ohpm i @lodz/pandora
```

### 直接引用
在entry的oh-package.json5里面可以直接引用
```
  "dependencies": {
    "@lodz/pandora": "1.0.6"
  }
```

## 2.内部依赖
Pandora内部集成了包括[core_hos](https://github.com/LZ9/AgileDevHOS/blob/main/core/README.md)等常用的工具组件，
如果你的工程**oh-package.json5**有重复引用可以选择去掉顶层引用或者保证版本一致

```
{
  "dependencies": {
    "@lodz/core_hos": "1.0.5"
  }
}
```

## 3.基类
### Ability基类：BaseAbility
BaseAbility继承UIAbility，用户可以重写以下方法专注业务实现

```
// 对应onCreate()方法
protected startCreate() {} 

// 传入启动页布局文件路径
protected abstract getLayoutPath(): string 

// 在loadContent完成之后调用
protected endCreate(windowStage: window.WindowStage) {} 

// 支持全局配置基础状态控件的参数
protected createBaseContainerScopeConfig(): BaseContainerScopeConfig | undefined {} 
```

### 页面容器基类：BaseContainer
BaseContainer是页面基类，通过属性BaseContainerVm来进行配置，基类包含状态栏，以及
加载页、内容页、错误页、空页面的状态显示切换，所有控件均使用@ComponentV2装饰器。

具体使用如下：

```
@Entry
@ComponentV2
struct XxxxPage {
  // 这里定义一个BaseContainer的ViewModel，用来控制基类的属性
  @Local private vm: BaseContainerVm = new BaseContainerVm()
 
  aboutToAppear(): void {
    // 调用该方法可以设置在BaseAbility里配置好的通用基础状态控件的参数
    this.vm.setScopeConfig()
    
    //这里可以对当前页面进行个性化参数配置，例如设置返回按钮监听、设置标题文字等等
    this.vm.titleBarViewVm.backImgVm.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.vm.titleBarViewVm.titleVm.title = $r('app.string.xxxx')
  }

  // 在build里使用BaseContainer，并传入配置属性和内容布局
  build() {
    Stack() {
      BaseContainer({
        vm: this.vm,
        contentLayout: () => {
          this.contentLayout()
        },
        titleBarExpandLayout: () => {
          this.expandLayout()
        }
      })
    }
  }

  // 自定义标题栏右侧菜单布局，不需要可以不写
  @Builder
  expandLayout() {
 
  }
  
  // 自定义内容布局，在contentLayout里编写具体的业务UI，例如：
  @Builder
  contentLayout() {
    Column() {

    }
    .width('100%')
    .height('100%')
  }
}
```
BaseContainer默认显示加载页，需要切换页面状态时，可以调用以下方法：
```
    // 显示加载页，当需要等待接口数据请求时，可以调用此方法
    this.vm.showStatusLoading()
    
    // 显示无数据页面，当无数据返回时，可以调用该方法
    this.vm.showStatusNoData()
    
    // 显示错误页面，当请求失败时，可以调用该方法
    this.vm.showStatusError()
    
    // 显示内容页，当完成数据请求，可以调用该方法
    this.vm.showStatusCompleted()
```

## 4.控件
### 标题栏：TitleBarView
封装了基础的标题栏控件，支持通过titleBarViewVm进行参数配置，右侧支持通过
expandLayout来配置菜单按钮，具体使用方式如下：
```
@Entry
@Component
struct XxxxPage {
  // 定义一个标题栏属性配置对象
  @State public vm: titleBarViewVm = new titleBarViewVm()

  aboutToAppear(): void {
    // 获取在Ability里配置好的标题栏属性并设置
    this.vm.setScopeConfig()
    
    // 根据需要对其他参数进行配置，例如设置返回按钮监听、设置标题文字等等
    this.vm.backImgVm.onClick = () => {

    }
    this.vm.titleVm.title = $r('app.string.xxxx')
  }

  // 右侧支持扩展布局，通过传入expandLayout()来自定义
  build() {
    Column() {
      TitleBarView({ 
        vm: this.vm ,     
        expandLayout: () => {
          this.expandLayout()
        }
      })
    }
    .width('100%')
    .height('100%')
  }

  //在自定义布局里开发具体UI和业务逻辑
  @Builder
  expandLayout() {
    Text($r('app.string.xxx'))
      .height(`100%`)
      .fontSize(12)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .padding({ left: 10, right: 10 })
      .onClick(() => {

      })
  }
}
```
## 5.扩展
### Promise扩展：PromiseAgent
通过对Promise的扩展封装，支持使用RxJava的方式来订阅数据，具体使用方式如下：
```
  /** 定义一个任务控制器 */
  private disposable?: Disposable
  
  aboutToDisappear(): void {
    // 在页面回收时取消任务订阅，避免内存溢出
    this.disposable?.dispose()
  }

  // 普通订阅方式
  private request() {
    this.disposable = PromiseAgent.create<T>()
      .then(() => ApiService.create().getXxxx())// 可以在这里链式调用多个Promise请求
      .subscribe({
        onSubscribe: () => {
          // 订阅开始
        },
        onNext: (data: T) => {
          // 接收到数据
        },
        onError: (e: DataError<T>) => {
          // 订阅过程中抛出异常
        },
        onFinally: () => {
          // 订阅结束
        }
      })
  }
```
支持使用加载框来订阅数据，订阅方法包括
1. subscribePgDef()：使用默认加载框样式
2. subscribePgAgent()：可对默认加载框进行样式配置
3. subscribePg()：完全自定义加载框样式

大家根据需要选择调用，下面以默认加载框样式为例说明具体使用方式：
```
  // 使用加载框订阅
  private requestProgress() {
    this.disposable = PromiseAgent.create<T>()
      .then(() => ApiService.create().getXxxx())
      .subscribePgDef(this.getUIContext(),
        {
          onSubscribe: () => {
            // 订阅开始
          },
          onNext: (data: T) => {
            // 接收到数据
          },
          onError: (e: DataError<T>) => {
            // 订阅过程中抛出异常
          },
          onFinally: () => {
            // 订阅结束
          },
          onPgCancel: () => {
            // 用户手动关闭加载框
          }
        }
      )
  }
```
### 加载框扩展：ProgressDialogAgent
可以使用ProgressDialogAgent来快速创建一个加载框，具体使用方式如下：
```
  private createProgressDialog(){
    // 都默认加载框样式进行配置
    const vm = new ProgressDialogVm()
    vm.textVm.content = $r('app.string.xxxx')

    ProgressDialogAgent.create()
      .setViewModel(vm)
      .setAutoCancel(true) // 是否自动取消
      .setMaskColor(Color.Transparent) // 设置加载框背景色
      .setOnWillDismiss((dismissDialogAction: DismissDialogAction) => { // 设置取消监听
        if (dismissDialogAction.reason == DismissReason.PRESS_BACK) { //按返回键取消
          dismissDialogAction.dismiss();
        }
        if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) { //点击空白区域取消
          dismissDialogAction.dismiss();
        }
      })
      .open(this.getUIContext()) // 显示加载框

    // 关闭加载框
    ProgressDialogAgent.close(this.getUIContext(), pgTag)
  }
```
也支持完全自定义加载框的显示和关闭，传入自定义的content: ComponentContent<T> 
和 options: promptAction.BaseDialogOptions，具体如下：
```
  private customProgressDialog() {
    const pgTag: ComponentContent<T> = ProgressDialogAgent.create().openCustom(this.getUIContext(), content, options)
    ProgressDialogAgent.close(this.getUIContext(), pgTag)
  }
```
## 6.其他工具

|       工具       | 描述        |
|:--------------:|:----------|
| StatusBarUtils | 支持设置状态栏颜色 |
