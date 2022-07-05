# Flutter

本文使用的环境是Xcode + Android studio

## 首先介绍一下几个概念。

### Modules

Flutter模块是Flutter和其他语言进行混编的支持方式。 对于很多项目来说，完全使用Flutter是不现实的，更多情况下只是某几个页面或者模块通过Flutter来实现。这时候我们就需要通过Modules来进行混编。


### Channels

Flutter代码中有时候不可避免地需要调用一些平台原生的API，比如说获取手机电量，打开相册等。这时候我们可以通过Channel来调用原生的objc, swift, java...等实现。


### Packages&Plugins

Package相当于iOS中的SDK。 而Plugin则是一种特殊的Package, 专门用来和原生平台的API进行交互。在一个Plugin中，我们可以实现多个平台的插件代码，而调用Flutter的代码实现是保持一致的。



## 学习路径

因为本身是一个iOS开发，对于混编有较大的需求。
因此对于我来说，首要目标是先弄清楚Flutter开发中的各个环节，项目创建， 混编，Native交互，Debug, 集成，上线等。

以下是我的学习路径： 

[开发环境配置]() :直接根据官方文档操作，非常详细，不再赘述

[Fluter App]()

[Flutter Channels]()

[Packages&Plugins]()

[Flutter Modules]() 

[Flutter Attach]()

[Dart语言基础]()


### Flutter App


安装完环境之后我们就可以开始创建我们的第一个Flutter App, 可以用以下两种方式. 因为Flutter是跨平台的，所以在创建时我们需要指定支持的平台和使用的语言。

1 Android Studio  -> File -> New Flutter Project

2 命令行：
```
//默认支持平台 ios , android , windows, linux , macos, web, 使用Swift和Kotlin语言
futter create my_app 

//手动指定支持的平台和语言
flutter create  --platforms  ios  --platforms android -i swift -a kotlin my_app 
 
```


创建完成后，我们可以看到目录底下有这三个文件夹lib, android, ios. 这时候我们可以用三种方式来运行这个工程，Flutter工程，android工程，iOS工程。 其中ios文件夹下Runner.xcworkspace是打开iOS工程的入口。

需要注意的是，直接运行android或者iOS工程的情况下，flutter相关的代码是以gradle或framework集成到工程的，无法直接调试。

lib文件夹下会默认生成一个main.dart文件，其中的main方法是整个程序的入口。文件默认实现了一个demo，直接可以运行。



### Flutter Channels

对于Flutter来说，很多功能需要通过Native交互来实现. 接下来我们来说一下flutter如何与Native交互。





### Packages&Plugins




### Flutter Modules


### Flutter Attach

### Dart语言基础

