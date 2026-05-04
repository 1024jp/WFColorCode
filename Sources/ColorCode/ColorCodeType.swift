//
//  ColorCodeType.swift
//
//  Created by 1024jp on 2021-05-08.

/*
 The MIT License (MIT)
 
 © 2014-2026 1024jp
 
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
    case hexWithAlpha
    
    /// 3-digit hexadecimal color code with # symbol. For example: `#fff`
    case shortHex
    
    /// 4-digit hexadecimal color code with # symbol. For example: `#fffa`
    case shortHexWithAlpha
    
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
    
    /// CSS style color code in HWB. For example: `hwb(0 0% 100%)`
    case cssHWB
    
    /// CSS style color code in HWB with alpha channel. For example: `hwb(0 0% 100% / 1)`
    case cssHWBWithAlpha
    
    
    public static let hexTypes: [Self] = [.hex, .hexWithAlpha, .shortHex, .shortHexWithAlpha]
    public static let cssTypes: [Self] = [.cssRGB, .cssRGBa, .cssHSL, .cssHSLa, .cssKeyword, .cssHWB, .cssHWBWithAlpha]
}


extension ColorCodeType {
    
    /// Returns the color components parsed as this color code type.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    func colorComponents(code: String) -> ColorComponents? {
        
        switch self {
        case .hex:
            Self.hexColorComponents(code: code)
        case .hexWithAlpha:
            Self.hexWithAlphaColorComponents(code: code)
        case .shortHex:
            Self.shortHexColorComponents(code: code)
        case .shortHexWithAlpha:
            Self.shortHexWithAlphaColorComponents(code: code)
        case .cssRGB:
            Self.cssRGBColorComponents(code: code)
        case .cssRGBa:
            Self.cssRGBaColorComponents(code: code)
        case .cssHSL:
            Self.cssHSLColorComponents(code: code)
        case .cssHSLa:
            Self.cssHSLaColorComponents(code: code)
        case .cssHWB:
            Self.cssHWBColorComponents(code: code)
        case .cssHWBWithAlpha:
            Self.cssHWBWithAlphaColorComponents(code: code)
        case .cssKeyword:
            Self.cssKeywordColorComponents(code: code)
        }
    }
}


private extension ColorCodeType {
    
    /// Returns the color components parsed from a 6-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func hexColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})/),
            let hex = Int(match.1, radix: 16)
        else { return nil }
        
        return ColorComponents(hex: hex)
    }
    
    
    /// Returns the color components parsed from an 8-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func hexWithAlphaColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})([0-9a-fA-F]{2})/),
            let hex = Int(match.1, radix: 16),
            let a = Int(match.2, radix: 16)
        else { return nil }
        
        return ColorComponents(hex: hex, alpha: Double(a) / 255)
    }
    
    
    /// Returns the color components parsed from a 3-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func shortHexColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/),
            let r = Int(match.1, radix: 16),
            let g = Int(match.2, radix: 16),
            let b = Int(match.3, radix: 16)
        else { return nil }
        
        return .rgb(Double(r) / 15, Double(g) / 15, Double(b) / 15)
    }
    
    
    /// Returns the color components parsed from a 4-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func shortHexWithAlphaColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/),
            let r = Int(match.1, radix: 16),
            let g = Int(match.2, radix: 16),
            let b = Int(match.3, radix: 16),
            let a = Int(match.4, radix: 16)
        else { return nil }
        
        return .rgb(Double(r) / 15, Double(g) / 15, Double(b) / 15, alpha: Double(a) / 15)
    }
    
    
    /// Returns the color components parsed from a CSS RGB color code without alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssRGBColorComponents(code: String) -> ColorComponents? {
        
        if let match = code.wholeMatch(of: /rgb\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\)/),
           let r = Double(match.1),
           let g = Double(match.2),
           let b = Double(match.3),
           (0.0...255.0).contains(r),
           (0.0...255.0).contains(g),
           (0.0...255.0).contains(b)
        {
            return .rgb(r / 255, g / 255, b / 255)
        }
        
        guard
            let match = code.wholeMatch(of: /rgb\( *([0-9.]+%?) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let r = Self.rgbComponent(match.1),
            let g = Self.rgbComponent(match.2),
            let b = Self.rgbComponent(match.3)
        else { return nil }
        
        return .rgb(r, g, b)
    }
    
    
    /// Returns the color components parsed from a CSS RGB color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssRGBaColorComponents(code: String) -> ColorComponents? {
        
        if let match = code.wholeMatch(of: /rgba\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3})(?: *, *([0-9.]+))? *\)/),
           let r = Double(match.1),
           let g = Double(match.2),
           let b = Double(match.3),
           let a = Self.optionalAlphaComponent(match.4),
           (0.0...255.0).contains(r),
           (0.0...255.0).contains(g),
           (0.0...255.0).contains(b),
           (0.0...1.0).contains(a)
        {
            return .rgb(r / 255, g / 255, b / 255, alpha: a)
        }
        
        guard
            let match = code.wholeMatch(of: /rgba?\( *([0-9.]+%?) +([0-9.]+%?) +([0-9.]+%?)(?: *\/ *([0-9.]+%?))? *\)/),
            let r = Self.rgbComponent(match.1),
            let g = Self.rgbComponent(match.2),
            let b = Self.rgbComponent(match.3),
            let a = Self.optionalAlphaComponent(match.4),
            (0.0...1.0).contains(a)
        else { return nil }
        
        return .rgb(r, g, b, alpha: a)
    }
    
    
    /// Returns the color components parsed from a CSS HSL color code without alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssHSLColorComponents(code: String) -> ColorComponents? {
        
        if let match = code.wholeMatch(of: /hsl\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\)/),
           let h = Double(match.1),
           let s = Double(match.2),
           let l = Double(match.3),
           (0.0...360.0).contains(h),
           (0.0...100.0).contains(s),
           (0.0...100.0).contains(l)
        {
            return .hsl(h / 360, s / 100, l / 100)
        }
        
        guard
            let match = code.wholeMatch(of: /hsl\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let s = Self.percentageComponent(match.2),
            let l = Self.percentageComponent(match.3),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(s),
            (0.0...100.0).contains(l)
        else { return nil }
        
        return .hsl(h / 360, s / 100, l / 100)
    }
    
    
    /// Returns the color components parsed from a CSS HSL color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssHSLaColorComponents(code: String) -> ColorComponents? {
        
        if let match = code.wholeMatch(of: /hsla\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)%(?: *, *([0-9.]+))? *\)/),
           let h = Double(match.1),
           let s = Double(match.2),
           let l = Double(match.3),
           let a = Self.optionalAlphaComponent(match.4),
           (0.0...360.0).contains(h),
           (0.0...100.0).contains(s),
           (0.0...100.0).contains(l),
           (0.0...1.0).contains(a)
        {
            return .hsl(h / 360, s / 100, l / 100, alpha: a)
        }
        
        guard
            let match = code.wholeMatch(of: /hsla?\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?)(?: *\/ *([0-9.]+%?))? *\)/),
            let h = Double(match.1),
            let s = Self.percentageComponent(match.2),
            let l = Self.percentageComponent(match.3),
            let a = Self.optionalAlphaComponent(match.4),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(s),
            (0.0...100.0).contains(l),
            (0.0...1.0).contains(a)
        else { return nil }
        
        return .hsl(h / 360, s / 100, l / 100, alpha: a)
    }
    
    
    /// Returns the color components parsed from a CSS HWB color code without alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssHWBColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /hwb\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let w = Self.percentageComponent(match.2),
            let b = Self.percentageComponent(match.3),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(w),
            (0.0...100.0).contains(b)
        else { return nil }
        
        return .hwb(h / 360, w / 100, b / 100)
    }
    
    
    /// Returns the color components parsed from a CSS HWB color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssHWBWithAlphaColorComponents(code: String) -> ColorComponents? {
        
        guard
            let match = code.wholeMatch(of: /hwb\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\/ *([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let w = Self.percentageComponent(match.2),
            let b = Self.percentageComponent(match.3),
            let a = Self.alphaComponent(match.4),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(w),
            (0.0...100.0).contains(b),
            (0.0...1.0).contains(a)
        else { return nil }
        
        return .hwb(h / 360, w / 100, b / 100, alpha: a)
    }
    
    
    /// Returns the color components parsed from a CSS keyword.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    static func cssKeywordColorComponents(code: String) -> ColorComponents? {
        
        guard
            code.wholeMatch(of: /[a-zA-Z]+/) != nil,
            let color = KeywordColor(keyword: code)
        else { return nil }
        
        return ColorComponents(hex: color.value)
    }
    
    
    /// Returns the numeric value of the given percentage component.
    ///
    /// - Parameter value: The component string with or without the percent sign.
    /// - Returns: The numeric percentage value.
    static func percentageComponent(_ value: some StringProtocol) -> Double? {
        
        let value = String(value)
        let number = value.hasSuffix("%") ? String(value.dropLast()) : value
        
        return Double(number)
    }
    
    
    /// Returns the RGB value of the given CSS RGB component.
    ///
    /// - Parameter value: The RGB component string as a number or percentage.
    /// - Returns: The RGB value between `0.0` and `1.0`.
    static func rgbComponent(_ value: some StringProtocol) -> Double? {
        
        let value = String(value)
        
        if value.hasSuffix("%") {
            guard
                let component = Double(value.dropLast()),
                (0.0...100.0).contains(component)
            else {
                return nil
            }
            
            return component / 100
        }
        
        guard
            let component = Double(value),
            (0.0...255.0).contains(component)
        else {
            return nil
        }
        
        return component / 255
    }
    
    
    /// Returns the alpha value of the given CSS alpha component.
    ///
    /// - Parameter value: The alpha component string as a number or percentage.
    /// - Returns: The alpha value between `0.0` and `1.0`.
    static func alphaComponent(_ value: some StringProtocol) -> Double? {
        
        let value = String(value)
        
        if value.hasSuffix("%") {
            guard let alpha = Double(value.dropLast()) else {
                return nil
            }
            
            return alpha / 100
        }
        
        return Double(value)
    }
    
    
    /// Returns the alpha value of the given optional CSS alpha component, or `1.0` if omitted.
    ///
    /// - Parameter value: The optional alpha component string as a number or percentage.
    /// - Returns: The alpha value between `0.0` and `1.0`.
    static func optionalAlphaComponent<Value: StringProtocol>(_ value: Value?) -> Double? {
        
        if let value {
            Self.alphaComponent(value)
        } else {
            1
        }
    }
}
