# Pandora库
Pandora是基于鸿蒙开发的敏捷开发解决方案，里面包括了鸿蒙APP基础开发需要用到的大部分基类、控件和工具。
你可以直接引用Pandora进行上层UI和业务逻辑开发，或者从中抽取你需要模块代码支援你的工程

### 项目地址
Github：[源码](https://github.com/LZ9/AgileDevHOS)

### 下载安装

```
ohpm i @lodz/pandora
```

## 内部依赖
Pandora内部集成了包括[core_hos](https://github.com/LZ9/AgileDevHOS/blob/main/core/README.md)等常用的工具组件，
如果你的工程**oh-package.json5**有重复引用可以选择去掉顶层引用或者保证版本一致

```
{
  "dependencies": {
    "@lodz/core_hos": "1.0.1"
  }
}
```

## 基类
### Ability基类：BaseAbility
BaseAbility继承UIAbility，用户可以重写以下方法专注业务实现

```
// 对应onCreate()方法
protected startCreate() {} 

// 传入启动页布局文件路径
protected abstract getLayoutPath(): string 

// 在loadContent完成之后调用
protected endCreate() {} 

// 支持全局配置基础状态控件的参数
protected configBaseContainerAttribute(): BaseContainerAttribute | undefined {} 
```

### 页面容器基类：BaseContainer
BaseContainer是页面基类，通过属性BaseContainerAttribute来进行配置，基类包含状态栏，以及
加载页、内容页、错误页、空页面的状态显示切换。

具体使用如下：

```
@Entry
@Component
struct XxxxPage {
  // 这里定义一个属性遍历，用来配置和控件BaseContainer
  @State attribute: BaseContainerAttribute = new BaseContainerAttribute()
 
  aboutToAppear(): void {
    // 调用该方法可以设置在BaseAbility里配置好的通用基础状态控件的参数
    this.attribute.setScopeConfig()
    
    //这里可以对当前页面进行个性化参数配置，例如设置返回按钮监听、设置标题文字等等
    this.attribute.titleBarViewAttribute.backImgOptions.onClick = () => {
      RouterUtils.back(this.getUIContext())
    }
    this.attribute.titleBarViewAttribute.titleOptions.title = $r('app.string.xxxx')
  }

  // 在build里使用BaseContainer，并传入配置属性和内容布局
  build() {
    Stack() {
      BaseContainer({
        attribute: this.attribute,
        contentLayout: () => {
          this.contentLayout()
        }
      })
    }
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
    this.attribute.showStatusLoading()
    
    // 显示无数据页面，当无数据返回时，可以调用该方法
    this.attribute.showStatusNoData()
    
    // 显示错误页面，当请求失败时，可以调用该方法
    this.attribute.showStatusError()
    
    // 显示内容页，当完成数据请求，可以调用该方法
    this.attribute.showStatusCompleted()
```

## 控件
### 标题栏：TitleBarView
封装了基础的标题栏控件，支持通过TitleBarViewAttribute进行参数配置，右侧支持通过
expandLayout来配置菜单按钮，具体使用方式如下：
```
@Entry
@Component
struct XxxxPage {
  // 定义一个标题栏属性配置对象
  @State public attribute: TitleBarViewAttribute = new TitleBarViewAttribute()

  aboutToAppear(): void {
    // 获取在Ability里配置好的标题栏属性并设置
    this.attribute.setScopeConfig()
    
    // 根据需要对其他参数进行配置，例如设置返回按钮监听、设置标题文字等等
    this.attribute.backImgOptions.onClick = () => {

    }
    this.attribute.titleOptions.title = $r('app.string.xxxx')
  }

  // 右侧支持扩展布局，通过传入expandLayout()来自定义
  build() {
    Column() {
      TitleBarView({ 
        attribute: this.attribute ,     
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

## 工具

|       工具       | 描述        |
|:--------------:|:----------|
| StatusBarUtils | 支持设置状态栏颜色 |
