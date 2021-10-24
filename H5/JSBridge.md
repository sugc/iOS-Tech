#iOS JSBridge实现

jsbridge是实现JS和Navite应用交互的一种方式，分为JS调Native和Native调JS.这边以WKWebView为例讲一下JSBridge的实现。[demo地址](https://github.com/sugc/iOS-JSBridge)


##Native调H5
Native调JS的方式比较简单, 通过以下方法可以直接执行一段JS脚本，并获取返回值



```
 public func evaluateJavaScript(_ javaScript: String, in frame: WKFrameInfo? = nil, in contentWorld: WKContentWorld, completionHandler: ((Result<Any, Error>) -> Void)? = nil)

```

###例子:




##H5调Navite
JS调Native本质都是Native通过拦截H5的回调，解析之后根据参数执行native代码，再回调结果到JS. 目前所了解到的正常主要有以下两种方式。

###1,拦截跳转url

```javascript
<!--JS-->
var iframe = document.createElement('iframe');
iframe.style.with = '1px';
iframe.style.height = '1px';
iframe.style.display = 'none';
iframe.src = url;
document.body.appendChild(iframe);

```

```Objective-C
//Native
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
	if navigationAction.request.url?.scheme == "jsbridge" {
		// 拦截自定义scheme,进行jsbridge处理
		decisionHandler(.cancel)
		return
	}  
	decisionHandler(.allow)
}
   
```

###2,拦截prompt回调

```
//JS
var returenValue = prompt(url);

```

```
//Native
func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
	if prompt.hasPrefix("JSBridge://") {
		// 拦截自定义scheme,进行jsbridge处理
	}
}
```

目前主流应该是使用第一种方式，第二种方式实际是系统定义好的调用Native输入框的API，这种使用方式不太符合规范，但好处是可以直接将参数转成string直接返回。而第一种方式需要定义回调JS用来返回Native的执行结果。



##如何设计一个好用的JSBridge
这边通过拦截跳转Url的方式来设计一个JSBridge实现JS调Native, 主要包含以下几块

* 协议定义  
* JS调Native方法  
* Native解析执行模块  
* Native回调JS方法


####1 首先看看协议怎么定，协议包含以下两部分  

> 
* 拦截scheme, 如JSBridge, 只要不和常见的scheme冲突即可    
> 
* 参数定义：  
  包含以下几部分部分，参数包成字典，以JSONString的形式拼在url参数中 
>> Native方法名  
>> JS调Native参数  
>> Native如何回调JS的参数  

> 示例:(未编码) JSBridge://methodName?params={nativeParam={},callback='xxx'}

	

####2 Native解析代码就不展开说了，iOS开发都熟，具体可以看看demo。下面说说JS部分如何设计。

Native回调JS的关键在于，如何去保存和寻找每次JS调用的回调方法。可以通过JS侧用一个字典保存这些回调，然后将key传给Native, Native执行完毕之后，再将返回值和key一起回调到JS。


```javascript
var responseCallbacks = {}
var messageID = 0

<!--调用Native方法-->
function callHandler(handlerName, data, responseCallback) {

	 <!--保存JS回调，由于可能多次调用，因此每次key都要不同-->
	 if (responseCallback) {
		var callbackId = messageID + handlerName;
		messageID = messageID + 1
		responseCallbacks[callbackId] = responseCallback
		args.push(callbackId)
	}
	
}

<!--Native回调JS-->
function callBackJS(methodKey, param){
	callBack = responseCallbacks[methodKey]
	if (callback) {
		callback(param)
	}
}
```





