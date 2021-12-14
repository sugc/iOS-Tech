//
//  UIFont+CSSString.swift
//  MGUIKit
//
//  Created by sugc on 2021/12/13.
//

import Foundation
import UIKit
import CoreFoundation
import CoreGraphics

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
