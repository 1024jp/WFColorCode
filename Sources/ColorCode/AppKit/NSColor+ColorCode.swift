//
//  NSColor+ColorCode.swift
//
//  Created by 1024jp on 2014-04-22.

/*
 The MIT License (MIT)
 
 © 2014-2022 1024jp
 
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

/// This extension on NSColor allows creating NSColor instance from a CSS color code string, or color code string from a NSColor instance.
public extension NSColor {
    
    /// Initialize with the given color code. Or returns `nil` if color code is invalid.
    ///
    /// Example usage:
    /// ```
    /// var type: ColorCodeType?
    /// let whiteColor = NSColor(colorCode: "hsla(0,0%,100%,0.5)", type: &type)
    /// let hex = whiteColor.colorCode(type: .hex)  // => "#ffffff"
    /// ```
    ///
    /// - Parameters:
    ///   - colorCode: The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
    ///   - type: Upon return, contains the detected color code type.
    convenience init?(colorCode: String, type: inout ColorCodeType?) {
        
        guard let components = ColorComponents(colorCode: colorCode, type: &type) else {
            return nil
        }
        
        self.init(components: components)
    }
    
    
    /// Initialize with the given color code. Or returns `nil` if color code is invalid.
    ///
    /// - Parameter colorCode: The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
    convenience init?(colorCode: String) {
        
        var type: ColorCodeType?
        
        self.init(colorCode: colorCode, type: &type)
    }
    
    
    /// Initialize with the given hex color code. Or returns `nil` if color code is invalid.
    ///
    /// Example usage:
    /// ```
    /// let redColor = NSColor(hex: 0xFF0000)
    /// let hex = redColor.colorCode(type: .hex)  // => "#ff0000"
    /// ```
    ///
    /// - Parameters:
    ///   - hex: The 6-digit hexadecimal color code.
    convenience init?(hex: Int) {
        
        guard let components = ColorComponents(hex: hex) else {
            return nil
        }
        
        self.init(components: components)
    }
    
    
    /// Creates and returns a `<String, NSColor>` paired dictionary represents all keyword colors specified in CSS3. The names are in upper camel-case.
    static var stylesheetKeywordColors: [String: NSColor] = colorKeywordMap.mapValues { NSColor(hex: $0)! }
    
    
    /// Returns the receiver’s color code in desired type.
    ///
    /// This method works only with objects representing colors in the `NSColorSpaceName.calibratedRGB` or
    /// `NSColorSpaceName.deviceRGB` color space. Sending it to other objects raises an exception.
    ///
    /// - Parameter type: The type of color code to format the returned string. You may use one of the types listed in `ColorCodeType`.
    /// - Returns: The color code string formatted in the input type.
    func colorCode(type: ColorCodeType) -> String? {
        
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
            let hex = (r & 0xff) << 16 | (g & 0xff) << 8 | (b & 0xff)
            return colorKeywordMap.first { $0.value == hex }?.key
        }
    }
}



extension NSColor {
    
    internal convenience init(components: ColorComponents) {
        
        switch components {
        case let .rgb(r, g, b, alpha: alpha):
            self.init(calibratedRed: r, green: g, blue: b, alpha: alpha)
            
        case let .hsl(h, s, l, alpha: alpha):
            self.init(calibratedHue: h, saturation: s, lightness: l, alpha: alpha)
            
        case let .hsb(h, s, b, alpha: alpha):
            self.init(calibratedHue: h, saturation: s, brightness: b, alpha: alpha)
        }
    }
    
}
