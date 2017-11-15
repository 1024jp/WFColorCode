//
//  NSColor+ColorCode.swift
//
//  Created by 1024jp on 2014-04-22.

/*
 The MIT License (MIT)
 
 Copyright (c) 2014-2017 1024jp
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation
import AppKit.NSColor

public enum ColorCodeType: Int {
    
    /// Color code is invalid.
    case invalid
    
    /// 6-digit hexadecimal color code with # symbol. For example: `#ffffff`
    case hex
    
    /// 3-digit hexadecimal color code with # symbol. For example: `#fff`
    case shortHex
    
    /// CSS style color code in RGB. For example: `rgb(255,255,255)`
    case cssRGB
    
    /// CSS style color code in RGB with alpha channel. For example: `rgba(255,255,255,1)`
    case cssRGBa
    
    /// CSS style color code in HSL. For example: `hsl(0,0%,100%)`
    case cssHSL
    
    /// CSS style color code in HSL with alpha channel. For example: `hsla(0,0%,100%,1)`
    case cssHSLa
    
    /// CSS style color code with keyrowd. For example: `White`
    case cssKeyword
}



/**
 This extension on NSColor allows creating NSColor instance from a CSS color code string, or color code string from a NSColor instance.
 */
public extension NSColor {
    
    /**
     Creates and returns a `NSColor` object using the given color code. Or returns `nil` if color code is invalid.
     
     Example usage:
     ```
     var colorCodeType: WFColorCodeType = .invalid
     let whiteColor = NSColor(colorCode: "hsla(0,0%,100%,0.5)", codeTypfe: &colorCodeType)
     let hex = whiteColor.colorCode(type: .hex)  // => "#ffffff"
     ```
     
     - parameter colorCode:  The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
     - parameter type:       Upon return, contains the detected color code type.
     - returns:              The color object.
     */
    public convenience init?(colorCode: String, type: UnsafeMutablePointer<ColorCodeType>? = nil) {
        
        let code = colorCode.trimmingCharacters(in: .whitespacesAndNewlines)
        let codeRange = NSRange(location: 0, length: code.utf16.count)
        
        let patterns: [ColorCodeType: String] = [
            .hex: "^#[0-9a-fA-F]{6}$",
            .shortHex: "^#[0-9a-fA-F]{3}$",
            .cssRGB: "^rgb\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\\)$",
            .cssRGBa: "^rgba\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9.]+) *\\)$",
            .cssHSL: "^hsl\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\\)$",
            .cssHSLa: "^hsla\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *, *([0-9.]+) *\\)$",
            .cssKeyword: "^[a-zA-Z]+$",
            ]
        
        // detect code type
        var detectedCodeType: ColorCodeType = .invalid
        var result: NSTextCheckingResult!
        for (key, pattern) in patterns {
            let regex = try! NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: code, range: codeRange)
            if let match = matches.first, matches.count == 1 {
                detectedCodeType = key
                result = match
                break
            }
        }
        
        type?.pointee = detectedCodeType
        
        // create color from result
        switch detectedCodeType {
        case .hex:
            let hex = Int(String(code.dropFirst()), radix: 16) ?? 0
            self.init(hex: hex)
            
        case .shortHex:
            let hex = Int(String(code.dropFirst()), radix: 16) ?? 0
            let r = (hex & 0xF00) >> 8
            let g = (hex & 0x0F0) >> 4
            let b = (hex & 0x00F)
            self.init(calibratedRed: CGFloat(r) / 15, green: CGFloat(g) / 15, blue: CGFloat(b) / 15, alpha: 1.0)
            
        case .cssRGB:
            let r = Double(code.substring(with: result.range(at: 1))) ?? 0
            let g = Double(code.substring(with: result.range(at: 2))) ?? 0
            let b = Double(code.substring(with: result.range(at: 3))) ?? 0
            self.init(calibratedRed: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1.0)
            
        case .cssRGBa:
            let r = Double(code.substring(with: result.range(at: 1))) ?? 0
            let g = Double(code.substring(with: result.range(at: 2))) ?? 0
            let b = Double(code.substring(with: result.range(at: 3))) ?? 0
            let a = Double(code.substring(with: result.range(at: 4))) ?? 1
            self.init(calibratedRed: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
            
        case .cssHSL:
            let h = Double(code.substring(with: result.range(at: 1))) ?? 0
            let s = Double(code.substring(with: result.range(at: 2))) ?? 0
            let l = Double(code.substring(with: result.range(at: 3))) ?? 0
            self.init(calibratedHue: CGFloat(h) / 360, saturation: CGFloat(s) / 100, lightness: CGFloat(l) / 100, alpha: 1.0)
            
        case .cssHSLa:
            let h = Double(code.substring(with: result.range(at: 1))) ?? 0
            let s = Double(code.substring(with: result.range(at: 2))) ?? 0
            let l = Double(code.substring(with: result.range(at: 3))) ?? 0
            let a = Double(code.substring(with: result.range(at: 4))) ?? 1
            self.init(calibratedHue: CGFloat(h) / 360, saturation: CGFloat(s) / 100, lightness: CGFloat(l) / 100, alpha: CGFloat(a))
            
        case .cssKeyword:
            let lowercase = code.lowercased()
            guard let hex = colorKeywordMap.first(where: { $0.key.lowercased() == lowercase })?.value
                else {
                    type?.pointee = .invalid
                    return nil
                }
            self.init(hex: hex)
            
        case .invalid:
            return nil
        }
    }
    
    
    /**
     Creates and returns a `NSColor` object using the given hex color code. Or returns `nil` if color code is invalid.
     
     Example usage:
     ```
     let redColor = NSColor(hex: 0xFF0000, alpha:1.0)
     let hex = redColor.colorCode(type: .hex)  // => "#ff0000"
     ```
     
     - parameter hex:        The 6-digit hexadecimal color code.
     - parameter alpha:      The opacity value of the color object.
     - returns:              The color object.
     */
    public convenience init?(hex: Int, alpha: CGFloat = 1.0) {
        
        guard (0...0xFFFFFF).contains(hex) else {
            return nil
        }
        
        let r = (hex & 0xFF0000) >> 16
        let g = (hex & 0x00FF00) >> 8
        let b = (hex & 0x0000FF)
        
        self.init(calibratedRed: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
    
    
    /**
     Creates and returns a `<String, NSColor>` paired dictionary represents all keyword colors specified in CSS3.
     
     - returns:              The Dcitonary of the stylesheet keyword names and colors pairs. The names are in upper camel case.
     */
    public static var stylesheetKeywordColors: [String: NSColor] {
        
        return colorKeywordMap.reduce([:]) { dict, item in
            var dict = dict
            dict[item.key] = NSColor(hex: item.value)
            return dict
        }
    }
    
    
    /**
     Returns the receiver’s color code in desired type.
     
     This method works only with objects representing colors in the `NSColorSpaceName.calibratedRGB` or `NSColorSpaceName.deviceRGB` color space. Sending it to other objects raises an exception.
     
     - parameter type:       The type of color code to format the returned string. You may use one of the types listed in `ColorCodeType`.
     - returns:              The color code string formatted in the input type.
     */
    public func colorCode(type: ColorCodeType) -> String? {
        
        let r = Int(round(255 * self.redComponent))
        let g = Int(round(255 * self.greenComponent))
        let b = Int(round(255 * self.blueComponent))
        let alpha = self.alphaComponent
        
        switch type {
        case .hex:
            return String(format: "#%02x%02x%02x", r, g, b)
            
        case .shortHex:
            return String(format: "#%1x%1x%1x", r / 16, g / 16, b / 16)
            
        case .cssRGB:
            return String(format: "rgb(%d,%d,%d)", r, g, b)
            
        case .cssRGBa:
            return String(format: "rgba(%d,%d,%d,%g)", r, g, b, alpha)
            
        case .cssHSL, .cssHSLa:
            let hue = self.hueComponent
            let saturation = self.hslSaturationComponent
            let lightness = self.lightnessComponent
            
            let h = (saturation > 0) ? Int(round(360 * hue)) : 0
            let s = Int(round(100 * saturation))
            let l = Int(round(100 * lightness))
            
            if type == .cssHSLa {
                return String(format: "hsla(%d,%d%%,%d%%,%g)", h, s, l, alpha)
            }
            return String(format: "hsl(%d,%d%%,%d%%)", h, s, l)
            
        case .cssKeyword:
            let rHex = (Int(r) & 0xff) << 16
            let gHex = (Int(g) & 0xff) << 8
            let bHex = (Int(b) & 0xff)
            let hex = rHex + gHex + bHex
            return colorKeywordMap.first { $0.value == hex }?.key
            
        case .invalid:
            return nil
        }
    }
    
}



private extension String {
    
    func substring(with range: NSRange) -> String {
        
        return (self as NSString).substring(with: range)
    }
    
}
