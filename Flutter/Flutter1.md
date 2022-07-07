# Flutter

本文使用的环境是Xcode + Android studio

## 首先介绍一下几个概念。

### Modules

Flutter模块是Flutter和其他语言进行混编的支持方式。 对于很多项目来说，完全使用Flutter是不现实的，更多情况下只是某几个页面或者模块通过Flutter来实现。这时候我们就需要通过Flutert Module来进行混编。


### Channels

Flutter代码中有时候不可避免地需要调用一些平台原生的API，比如说获取手机电量，打开相册等。这时候我们可以通过Channel来调用原生的objc, swift, java...等实现。


### Packages&Plugins

Package相当于iOS中的SDK。 而Plugin则是一种特殊的Package, 专门用来和原生平台的API进行交互。在一个Plugin中，我们可以实现多个平台的插件代码，而调用Flutter的代码实现是保持一致的。


## 学习路径

因为本身是一个iOS开发，对于混编有较大的需求。
因此对于我来说，首要目标是先弄清楚Flutter开发中的各个环节，项目创建， 混编，Native交互，Debug, 集成，上线等。

以下是我的学习路径： 

[开发环境配置](https://docs.flutter.dev/get-started/install) :直接根据官方文档操作，非常详细，不再赘述

[Fluter App](#Fluter_App)

[Flutter Channels](#Flutter_Channels)

[Packages&Plugins](#Packages&Plugins)

[Flutter Modules](#Flutter_Modules) 

[iOS工程添加Flutter页面](#iOS工程添加Flutter页面)

[Flutter Attach](#Flutter_Attach)

[Dart语言基础](#Dart语言基础)


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


至于Flutter相关控件这边就不再赘述，可以看以下官方文档，了解常用的UI控件如何使用。[官方文档]()



### <a id="Flutter_Channels"></a> Flutter Channels

对于Flutter来说，很多功能需要通过Native交互来实现. 接下来我们来说一下flutter如何与Native交互。



### <a id="Packages&Plugins"></a>Packages&Plugins

Flutter Packages和Plugins没有本质上的差别，Plugins是一种特殊的Packages，是专门用来和Native交互的代码组成的Packages。

#### package

通过以下命名可以创建一个package

```
flutter create --template=package my_module
```

引入一个package的方式比较简单。例如我们要添加url_launcher 5.4.0版本.

1 在pubspec.yaml文件中，添加如下配置。

```
ependencies:                //默认创建
  flutter:                  //默认创建
    sdk: flutter            //默认创建
url_launcher:^5.4.0         //新添加
```

2 添加完成后运行命令, 更新依赖。

```
flutter pub get
```

3 使用时在对应的文件中引用相关package，如在main.dart

```

```





#### plugin



### <a id="Flutter_Modules"></a>Flutter Modules

使用以下代码就能快速创建一个Flutter Module。
创建的flutter module可以通过Android studio打开并进行开发。和flutter app没有什么太大不同。

```
flutter create --template module my_flutter

```


Module整体的目录结构如下

```
my_flutter/
├── .ios/
│   ├── Runner.xcworkspace
│   └── Flutter/podhelper.rb
├── lib/
│   └── main.dart
├── test/
└── pubspec.yaml

```
通过CocoaPods可以很方便地加入到iOS工程中。其他方式可以参考官方文档：[官方文档](https://docs.flutter.dev/development/add-to-app/ios/project-setup)

1 将以下代码加到Podfile中
```
flutter_application_path = '../my_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

```
2 每个需要使用flutter的target中添加以下代码

```
target 'MyApp' do
    install_all_flutter_pods(flutter_application_path)
end

```

3 Podfile中的post_install添加以下代码
```
post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
```

pod install之后，整个功能就能直接使用flutter了， 如果你的flutter module中引入了其他packages，在pod install之前需要先运行以下命令。

```
flutter pub get
```



### <a id='iOS工程添加Flutter页面'></a> iOS工程添加Flutter页面

将flutter嵌入到iOS工程中后，我们需要将flutter页面展示出来。

1 创建并注册flutter引擎

```
let flutterEngine = FlutterEngine(name:"my flutter engine")
flutterEngine.run()
GeneratedPluginRegistrant.register(with:flutterEngine)

```

2 创建并展示flutter页面

```
let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
                
present(flutterViewController, animated: true, completion: nil)
```

### <a id="Flutter_Attach"></a>Flutter Attach

在混编的情况下，我们大部分情况下需要通过XCode去调试相关代码。但XCode是无法直接对flutter代码进行debug的，这时候就需要用到flutter attach的方式了。




### <a id="Dart语言基础"></a>Dart语言基础



#### [官方文档](https://dart.dev/samples)






