# Pandora库
Pandora是基于鸿蒙开发的敏捷开发解决方案，里面包括了鸿蒙APP基础开发需要用到的大部分基类、控件和工具。
你可以直接引用Pandora进行上层UI和业务逻辑开发，或者从中抽取你需要模块代码支援你的工程

### 项目地址
Github：[源码](https://github.com/LZ9/AgileDevHOS)

### 下载安装
```
ohpm install @lodz/pandora
```

## 内部依赖
Pandora内部集成了包括[core](https://github.com/LZ9/AgileDevHOS/blob/main/core/README.md)等常用的工具组件，
如果你的工程**oh-package.json5**有重复引用可以选择去掉顶层引用或者保证版本一致
```
{
  "dependencies": {
    "core": "1.0.1"
  }
}
```

### 工具清单
|        工具        | 描述                                      |
|:----------------:|:----------------------------------------|
|     PrintLog     | 主要对hilog进行了封装，简化了hilog的调用方式，支持日志开关，分段打印 |
|     AppUtils     | 封装了app常用工具类，如获取app版本号、包名、名称等            |
|    DateUtils     | 日期工具类，支持根据需要对指定日期格式进行转换                 |
|   DeviceUtils    | 设备信息工具类，支持获取当前设备信息，如分辨率、设备id等           |
|    JsonUtils     | 对Json字符串和Bean的转换进行封装，支持直接获取Bean对象       |
| PreferencesUtils | 封装了键值对缓存工具类，便于调用                        |                                |
|   PromptUtils    | 对常用提示框进行封装，包括toast、dialog、menu等         |                               |
|  ResourceUtils   | 对资源目录常见的获取进行封装，如获取资源的字符串、颜色转换、raw文件读取等  |                             |
|   RouterUtils    | 路由工具，对常用的路由方法进行封装，便于调用                  |                                |
|   StringUtils    | 对string常用的方法进行封装，便于调用                   |                                     |      


