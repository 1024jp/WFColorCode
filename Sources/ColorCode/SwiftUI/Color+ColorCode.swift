//
//  Color+ColorCode.swift
//
//  Created by 1024jp on 2021-05-08.

/*
 The MIT License (MIT)
 
 © 2014-2021 1024jp
 
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

import SwiftUI

/// This extension on Color allows creating Color instance from a CSS color code string.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension Color {
    
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
    init?(colorCode: String, type: inout ColorCodeType?) {
        
        guard let components = ColorComponents(colorCode: colorCode, type: &type) else {
            return nil
        }
        
        self.init(components: components)
    }
    
    
    /// Initialize with the given color code. Or returns `nil` if color code is invalid.
    ///
    /// - Parameter colorCode: The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
    init?(colorCode: String) {
        
        var type: ColorCodeType?
        
        self.init(colorCode: colorCode, type: &type)
    }
    
    
    /// Initialize with the given hex color code. Or returns `nil` if color code is invalid.
    ///
    /// Example usage:
    /// ```
    /// let redColor = NSColor(hex: 0xFF0000, alpha: 1.0)
    /// let hex = redColor.colorCode(type: .hex)  // => "#ff0000"
    /// ```
    ///
    /// - Parameters:
    ///   - hex: The 6-digit hexadecimal color code.
    ///   - alpha: The opacity value of the color object.
    init?(hex: Int, alpha: Double = 1.0) {
        
        guard let components = ColorComponents(hex: hex, alpha: alpha) else {
            return nil
        }
        
        self.init(components: components)
    }
    
}



@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    
    init(components: ColorComponents) {
        
        switch components {
            case let .rgb(r, g, b, alpha: alpha):
                self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
                
            case let .hsl(h, s, l, alpha: alpha):
                self.init(hue: h, saturation: s, lightness: l, opacity: alpha)
                
            case let .hsb(h, s, b, alpha: alpha):
                self.init(hue: h, saturation: s, brightness: b, opacity: alpha)
        }
    }
    
}
