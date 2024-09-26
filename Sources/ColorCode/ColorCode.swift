//
//  ColorCode.swift
//
//  Created by 1024jp on 2021-05-08.

/*
 The MIT License (MIT)
 
 © 2014-2024 1024jp
 
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

public enum ColorCodeType: Int, CaseIterable, Sendable {
    
    /// 6-digit hexadecimal color code with # symbol. For example: `#ffffff`
    case hex = 1
    
    /// 8-digit hexadecimal color code with # symbol. For example: `#ffffffaa`
    case hexWithAlpha = 8
    
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
    
    /// CSS style color code with keyword. For example: `White`
    case cssKeyword
}



// MARK: Color Components

enum ColorComponents {
    
    case rgb(Double, Double, Double, alpha: Double = 1)
    case hsl(Double, Double, Double, alpha: Double = 1)
    case hsb(Double, Double, Double, alpha: Double = 1)
}


extension ColorComponents {
    
    /// Initialize with the given hex color code. Or returns `nil` if color code is invalid.
    ///
    /// Example usage:
    /// ```
    /// let redComponents = ColorComponents(hex: 0xFF0000)
    /// ```
    ///
    /// - Parameters:
    ///   - hex: The 6-digit hexadecimal color code.
    ///   - alpha: The alpha channel between `0.0` and `1.0`.
    init?(hex: Int, alpha: Double = 1) {
        
        assert((0...1).contains(alpha))
        
        guard (0...0xFFFFFF).contains(hex) else {
            return nil
        }
        
        let r = (hex >> 16) & 0xff
        let g = (hex >> 8) & 0xff
        let b = (hex) & 0xff
        
        self = .rgb(Double(r) / 255, Double(g) / 255, Double(b) / 255, alpha: alpha)
    }
    
    
    /// Initialize with the given color code. Or returns `nil` if color code is invalid.
    ///
    /// - Parameters:
    ///   - colorCode: The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
    ///   - type: Upon return, contains the detected color code type.
    init?(colorCode: String, type: inout ColorCodeType?) {
        
        // initialize with `nil` anyway
        type = nil
        
        let code = colorCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let (detectedType, components) = ColorCodeType.allCases.lazy
            .compactMap({ type -> (ColorCodeType, ColorComponents)? in
                guard let components = type.colorComponents(code: code) else { return nil }
                return (type, components)
            }).first else { return nil }
        
        type = detectedType
        self = components
    }
}


private extension ColorCodeType {
    
    func colorComponents(code: String) -> ColorComponents? {
        
        switch self {
            case .hex:
                guard
                    let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})/),
                    let hex = Int(match.1, radix: 16)
                else { return nil }
                return ColorComponents(hex: hex)
                
            case .hexWithAlpha:
                guard
                    let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})([0-9a-fA-F]{2})/),
                    let hex = Int(match.1, radix: 16),
                    let a = Int(match.2, radix: 16)
                else { return nil }
                return ColorComponents(hex: hex, alpha: Double(a) / 255)
                
            case .shortHex:
                guard
                    let match = code.wholeMatch(of: /#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/),
                    let r = Int(match.1, radix: 16),
                    let g = Int(match.2, radix: 16),
                    let b = Int(match.3, radix: 16)
                else { return nil }
                return .rgb(Double(r) / 15, Double(g) / 15, Double(b) / 15)
                
            case .cssRGB:
                guard
                    let match = code.wholeMatch(of: /rgb\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\)/),
                    let r = Double(match.1),
                    let g = Double(match.2),
                    let b = Double(match.3)
                else { return nil }
                return .rgb(r / 255, g / 255, b / 255)
                
            case .cssRGBa:
                guard
                    let match = code.wholeMatch(of: /rgba\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9.]+) *\)/),
                    let r = Double(match.1),
                    let g = Double(match.2),
                    let b = Double(match.3),
                    let a = Double(match.4)
                else { return nil }
                return .rgb(r / 255, g / 255, b / 255, alpha: a)
                
            case .cssHSL:
                guard
                    let match = code.wholeMatch(of: /hsl\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\)/),
                    let h = Double(match.1),
                    let s = Double(match.2),
                    let l = Double(match.3)
                else { return nil }
                return .hsl(h / 360, s / 100, l / 100)
                
            case .cssHSLa:
                guard
                    let match = code.wholeMatch(of: /hsla\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *, *([0-9.]+) *\)/),
                    let h = Double(match.1),
                    let s = Double(match.2),
                    let l = Double(match.3),
                    let a = Double(match.4)
                else { return nil }
                return .hsl(h / 360, s / 100, l / 100, alpha: a)
                
            case .cssKeyword:
                guard
                    code.wholeMatch(of: /[a-zA-Z]+/) != nil,
                    let color = KeywordColor(keyword: code)
                else { return nil }
                return ColorComponents(hex: color.value)
        }
    }
}
