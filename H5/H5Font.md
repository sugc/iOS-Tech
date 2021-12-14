# iOS 修改H5字体

在某些情况下我们会对App设置自定义的字体，这时候webView显示出来的字体就会不太一致，影响整体体验, 这时候我们就需要对webView的字体进行设置。

## 如何修改H5字体

实现原理并不复杂，CSS中可以使用font-face属性来实现调用任何外部等特殊字体。
	
Firefox、Chrome、Safari 以及 Opera 支持 .ttf (True Type Fonts) 和 .otf (OpenType Fonts) 类型的字体。 Internet Explorer 9+ 支持新的 font-face 规则，但是仅支持 .eot 类型的字体 (Embedded OpenType)。  

设置字体时需要一个family名称，设置normal和bold字体等，字体文件数据通过base64编码字符串形式传入。
 通过这种方式，我们可以通过JS脚本来设置H5页面的字体样式.


## 修改字体代码


以下是生成JS脚本的实现， 在H5页面加载完毕时执行该脚本即可。[代码下载](./code/UIFont+JSString.swift)

```
public extension UIFont {
    
    static func CSSJSString(normalFontUrl:URL!, boldFontUrl:URL!, italicFontUrl:URL!, italicBoldFontUrl:URL!)->String? {
        
        if (!normalFontUrl.absoluteString.hasSuffix(".ttf") && !normalFontUrl.absoluteString.hasSuffix(".otf")) ||
            (!boldFontUrl.absoluteString.hasSuffix(".ttf") && !boldFontUrl.absoluteString.hasSuffix(".otf")) ||
            (!italicFontUrl.absoluteString.hasSuffix(".ttf") && !italicFontUrl.absoluteString.hasSuffix(".otf")) ||
            (!italicBoldFontUrl.absoluteString.hasSuffix(".ttf") && !italicBoldFontUrl.absoluteString.hasSuffix(".otf"))  {
            assert(false, "font file should end with .ttf or .otf")
            return nil
        }
        


        let normalFamilyName = "Normal_FamilyName"
        var normalFontBase64 : String!
        var boldFontBase64 : String!
        var italicFontBase64 : String!
        var italicBoldFontBase64 : String!
        
        
        do {
            normalFontBase64 = try Data.init(contentsOf: normalFontUrl).base64EncodedString()
            boldFontBase64 = try Data.init(contentsOf: boldFontUrl).base64EncodedString()
            italicFontBase64 = try Data.init(contentsOf: italicFontUrl).base64EncodedString()
            italicBoldFontBase64 = try Data.init(contentsOf: italicBoldFontUrl).base64EncodedString()
            
        }catch {
            return nil
            
        }
        
       
        
        
        var jsString =
"""
var fontcss ='@font-face{font-family:"**family_name**";font-weight:normal;font-style:normal;src:url(data:font/ttf;base64,**regular**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:bold;font-style:normal;src:url(data:font/ttf;base64,**bold**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:500;font-style:normal;src:url(data:font/ttf;base64,**bold**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:600;font-style:normal;src:url(data:font/ttf;base64,**bold**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:800;font-style:normal;src:url(data:font/ttf;base64,**bold**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:normal;font-style:italic;src:url(data:font/ttf;base64,**regular_italic**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:bold;font-style:italic;src:url(data:font/ttf;base64,**bold_italic**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:500;font-style:italic;src:url(data:font/ttf;base64,**bold_italic**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:600;font-style:italic;src:url(data:font/ttf;base64,**bold_italic**) format("truetype");} @font-face{font-family:"**family_name**";font-weight:800;font-style:italic;src:url(data:font/ttf;base64,**bold_italic**) format("truetype");} *{font-family: "**family_name**" !important;}';             var head = document.getElementsByTagName('head')[0],             style = document.createElement('style');             style.type = 'text/css';             style.innerHTML = fontcss;             head.appendChild(style);

"""
        
        jsString = jsString.replacingOccurrences(of: "**family_name**", with:normalFamilyName)
        
        jsString = jsString.replacingOccurrences(of: "**regular**", with:normalFontBase64!)
        jsString = jsString.replacingOccurrences(of: "**bold**", with:boldFontBase64!)
        jsString = jsString.replacingOccurrences(of: "**regular_italic**", with:italicFontBase64!)
        jsString = jsString.replacingOccurrences(of: "**bold_italic**", with:italicBoldFontBase64!)
        
        return jsString
    }
    
    
}


```


