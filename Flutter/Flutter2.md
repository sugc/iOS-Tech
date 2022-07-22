# First Flutter App

## Basic structure of a Flutter app

## 常用 package



## <a id='Wdiget'>Widget</a> 

Widget是一个描述了一个视图该如何展示的不可变对象，在Flutter应用中，几乎所有的东西都是一个Widget, 在作用上类似于iOS中的UIView。

Widget分为两种：

1. StatelessWidget 无状态Widget, 这也意味着StatelessWidget展示的内容是固定的，不会跟随数据状态改变。

2. StatefulWidget， 有状态Widget。 本身是不可变对象，但会绑定一个可变的state, 展示的内容根据state进行刷新。

### StatelessWidget

创建一个StatelessWidget很简单，直接继承自StatelessWidget，并实现StatelessWidget.build方法。 

在Android studio中可以直接输入stless通过代码自动补全快速创建。

```
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### StatefulWidget

创建一个StatefulWidget需要创建以下两个类。

在Android studio中可以直接输入stful通过代码自动补全快速创建。

1. 继承自StatefulWidget，并通过StatefulWidget.createState方法返回绑定的State, 相同的StatefulWidget可能绑定不同的State。 如果一个StatefulWidget.createState从树中被移除并在之后被添加回树中，会再次调用createState方法去创建一个新的State。

```
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _MyStatefulWidgetState();
}
```
2. 继承自State, 并实现State.build方法。
```
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  String title; //声明变量
  
  @override
  Widget build(BuildContext context) {
    return Text(_title);
  }

}

```

如需要刷新状态，可以通过State.setState方法。

```
 setState(() {
   //通过代码块修改参数
   _title = 'my new title'
});
```


## Basic widgets

系统提供了一组强大的基础widget, 以下是一些常用的：

* #### Text 
    展示文字，相当于UILabel?

* #### Row, Column
    本身不展示任何内容，布局使用。 Row横向布局，添加到Row的widget会按照顺序横向排列。Column纵向布局，添加到Column的widget会按照顺序纵向排列。 

* #### Stack 
   本身不展示任何内容。添加到Stack的widget，会按照顺序在Z轴排列，相互之间会覆盖，相当于在UIView上添加多个subView的情况，后添加的视图会遮盖之前添加的视图。

* #### Container
    创建一个方形的虚拟元素，可以通过Decoration去装饰，比如背景，边框，阴影等，渐变色等，可通过三维矩阵进行变换。

```
 return Container(

      margin: const EdgeInsets.all(10),
      height: 150,

      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFE57373),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 1.0),
            blurStyle: BlurStyle.solid
          )
        ],
        gradient:LinearGradient(begin: Alignment.topLeft, end:Alignment.bottomRight ,colors:  [Colors.white,Colors.redAccent,Colors.greenAccent])
      ),
      child: Text('text')      
);
```

* #### Icon



## Navigation & Routing

对于不同场景，我们需要不同的页面来展示，当点击一个按钮时，我们可能会跳转到另一个页面去展示不同的内容。 在iOS中，我们使用ViewController, 在安卓中使用Activity, 而在Flutter中，是一个Widget。

在Flutter中有两种路由方式

1. ### Navigator

使用方式: 
* 新建两个widget FirstRoute 和 SecondRoute
* 从FirstRoute跳转到SecondRoute

```
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SecondRoute()),
  );
}
```

* 从SecondRoute返回到 FirstRoute

```
onPressed: () {
  Navigator.pop(context);
}
```





3. ### Router









