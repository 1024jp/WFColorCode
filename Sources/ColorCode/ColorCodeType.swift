//
//  ColorCodeType.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2021-05-08.
//
//  ---------------------------------------------------------------------------
//
//  The MIT License (MIT)
//
//  © 2014-2026 1024jp
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

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
    
    /// CSS style color code in HWB. For example: `hwb(0 0% 100%)`
    case cssHWB
    
    /// CSS style color code in HWB with alpha channel. For example: `hwb(0 0% 100% / 1)`
    case cssHWBWithAlpha
    
    /// CSS style color code with keyword. For example: `White`
    case cssKeyword
    
    
    public static let hexTypes: [Self] = [.hex, .hexWithAlpha, .shortHex, .shortHexWithAlpha]
    public static let cssTypes: [Self] = [.cssRGB, .cssRGBa, .cssHSL, .cssHSLa, .cssHWB, .cssHWBWithAlpha, .cssKeyword]
}


extension ColorCodeType {
    
    /// Returns the color components parsed as this color code type.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    func colorComponents(code: String) -> ColorComponents? {
        
        switch self {
        case .hex:
            RGB(hex: code).map { .rgb($0) }
        case .hexWithAlpha:
            RGB(hexWithAlpha: code).map { .rgb($0) }
        case .shortHex:
            RGB(shortHex: code).map { .rgb($0) }
        case .shortHexWithAlpha:
            RGB(shortHexWithAlpha: code).map { .rgb($0) }
        case .cssRGB:
            RGB(css: code).map { .rgb($0) }
        case .cssRGBa:
            RGB(cssWithAlpha: code).map { .rgb($0) }
        case .cssHSL:
            HSL(css: code).map { .hsl($0) }
        case .cssHSLa:
            HSL(cssWithAlpha: code).map { .hsl($0) }
        case .cssHWB:
            HWB(css: code).map { .hwb($0) }
        case .cssHWBWithAlpha:
            HWB(cssWithAlpha: code).map { .hwb($0) }
        case .cssKeyword:
            RGB(cssKeyword: code).map { .rgb($0) }
        }
    }
}


extension RGB {
    
    /// Initializes by parsing from a 6-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    init?(hex code: String) {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})/),
            let hex = Int(match.1, radix: 16)
        else { return nil }
        
        self.init(hex: hex)
    }
    
    
    /// Initializes by parsing from an 8-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    init?(hexWithAlpha code: String) {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F]{6})([0-9a-fA-F]{2})/),
            let hex = Int(match.1, radix: 16),
            let alpha = Int(match.2, radix: 16)
        else { return nil }
        
        self.init(hex: hex, alpha: Double(alpha) / 255)
    }
    
    
    /// Initializes by parsing from a 3-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    init?(shortHex code: String) {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/),
            let r = Int(match.1, radix: 16),
            let g = Int(match.2, radix: 16),
            let b = Int(match.3, radix: 16)
        else { return nil }
        
        self.init(red: Double(r) / 15, green: Double(g) / 15, blue: Double(b) / 15)
    }
    
    
    /// Initializes by parsing from a 4-digit hex color code.
    ///
    /// - Parameter code: The color code string to parse.
    init?(shortHexWithAlpha code: String) {
        
        guard
            let match = code.wholeMatch(of: /#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/),
            let r = Int(match.1, radix: 16),
            let g = Int(match.2, radix: 16),
            let b = Int(match.3, radix: 16),
            let alpha = Int(match.4, radix: 16)
        else { return nil }
        
        self.init(red: Double(r) / 15, green: Double(g) / 15, blue: Double(b) / 15, alpha: Double(alpha) / 15)
    }
    
    
    /// Initializes by parsing from a CSS RGB color code without alpha.
    ///
    /// - Parameter code: The color code string to parse.
    init?(css code: String) {
        
        if let match = code.wholeMatch(of: /rgb\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\)/),
           let r = Double(match.1),
           let g = Double(match.2),
           let b = Double(match.3),
           (0...255).contains(r),
           (0...255).contains(g),
           (0...255).contains(b)
        {
            self.init(red: r / 255, green: g / 255, blue: b / 255)
            return
        }
        
        guard
            let match = code.wholeMatch(of: /rgb\( *([0-9.]+%?) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let r = Self.rgbComponent(match.1),
            let g = Self.rgbComponent(match.2),
            let b = Self.rgbComponent(match.3)
        else { return nil }
        
        self.init(red: r, green: g, blue: b)
    }
    
    
    /// Initializes by parsing from a CSS RGB color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    init?(cssWithAlpha code: String) {
        
        if let match = code.wholeMatch(of: /rgba\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3})(?: *, *([0-9.]+))? *\)/),
           let r = Double(match.1),
           let g = Double(match.2),
           let b = Double(match.3),
           let a = optionalAlphaComponent(match.4),
           (0...255).contains(r),
           (0...255).contains(g),
           (0...255).contains(b),
           (0...1).contains(a)
        {
            self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
            return
        }
        
        guard
            let match = code.wholeMatch(of: /rgba?\( *([0-9.]+%?) +([0-9.]+%?) +([0-9.]+%?)(?: *\/ *([0-9.]+%?))? *\)/),
            let r = Self.rgbComponent(match.1),
            let g = Self.rgbComponent(match.2),
            let b = Self.rgbComponent(match.3),
            let a = optionalAlphaComponent(match.4),
            (0.0...1.0).contains(a)
        else { return nil }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    
    /// Initializes by parsing from a CSS keyword.
    ///
    /// - Parameter keyword: The color code string to parse.
    init?(cssKeyword keyword: String) {
        
        guard
            keyword.wholeMatch(of: /[a-zA-Z]+/) != nil,
            let color = KeywordColor(keyword: keyword)
        else { return nil }
        
        self.init(hex: color.value)
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
}


extension HSL {
    
    /// Initializes by parsing from a CSS HSL color code without alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    init?(css code: String) {
        
        if let match = code.wholeMatch(of: /hsl\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\)/),
           let h = Double(match.1),
           let s = Double(match.2),
           let l = Double(match.3),
           (0.0...360.0).contains(h),
           (0.0...100.0).contains(s),
           (0.0...100.0).contains(l)
        {
            self.init(hue: h / 360, saturation: s / 100, lightness: l / 100)
            return
        }
        
        guard
            let match = code.wholeMatch(of: /hsl\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let s = percentageComponent(match.2),
            let l = percentageComponent(match.3),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(s),
            (0.0...100.0).contains(l)
        else { return nil }
        
        self.init(hue: h / 360, saturation: s / 100, lightness: l / 100)
    }
    
    
    /// Initializes by parsing from a CSS HSL color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    /// - Returns: The parsed color components.
    init?(cssWithAlpha code: String) {
        
        if let match = code.wholeMatch(of: /hsla\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)%(?: *, *([0-9.]+))? *\)/),
           let h = Double(match.1),
           let s = Double(match.2),
           let l = Double(match.3),
           let a = optionalAlphaComponent(match.4),
           (0.0...360.0).contains(h),
           (0.0...100.0).contains(s),
           (0.0...100.0).contains(l),
           (0.0...1.0).contains(a)
        {
            self.init(hue: h / 360, saturation: s / 100, lightness: l / 100, alpha: a)
            return
        }
        
        guard
            let match = code.wholeMatch(of: /hsla?\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?)(?: *\/ *([0-9.]+%?))? *\)/),
            let h = Double(match.1),
            let s = percentageComponent(match.2),
            let l = percentageComponent(match.3),
            let a = optionalAlphaComponent(match.4),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(s),
            (0.0...100.0).contains(l),
            (0.0...1.0).contains(a)
        else { return nil }
        
        self.init(hue: h / 360, saturation: s / 100, lightness: l / 100, alpha: a)
    }
}


extension HWB {
    
    /// Initializes by parsing from a CSS HWB color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    init?(css code: String) {
        
        guard
            let match = code.wholeMatch(of: /hwb\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let w = percentageComponent(match.2),
            let b = percentageComponent(match.3),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(w),
            (0.0...100.0).contains(b)
        else { return nil }
        
        self.init(hue: h / 360, whiteness: w / 100, blackness: b / 100)
    }
    
    
    /// Initializes by parsing from a CSS HWB color code with alpha.
    ///
    /// - Parameter code: The color code string to parse.
    init?(cssWithAlpha code: String) {
        
        guard
            let match = code.wholeMatch(of: /hwb\( *([0-9.]+) +([0-9.]+%?) +([0-9.]+%?) *\/ *([0-9.]+%?) *\)/),
            let h = Double(match.1),
            let w = percentageComponent(match.2),
            let b = percentageComponent(match.3),
            let a = alphaComponent(match.4),
            (0.0...360.0).contains(h),
            (0.0...100.0).contains(w),
            (0.0...100.0).contains(b),
            (0.0...1.0).contains(a)
        else { return nil }
        
        self.init(hue: h / 360, whiteness: w / 100, blackness: b / 100, alpha: a)
    }
}


/// Returns the numeric value of the given percentage component.
///
/// - Parameter value: The component string with or without the percent sign.
/// - Returns: The numeric percentage value.
private func percentageComponent(_ value: some StringProtocol) -> Double? {
    
    let value = String(value)
    let number = value.hasSuffix("%") ? String(value.dropLast()) : value
    
    return Double(number)
}


/// Returns the alpha value of the given CSS alpha component.
///
/// - Parameter value: The alpha component string as a number or percentage.
/// - Returns: The alpha value between `0.0` and `1.0`.
private func alphaComponent(_ value: some StringProtocol) -> Double? {
    
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
private func optionalAlphaComponent<Value: StringProtocol>(_ value: Value?) -> Double? {
    
    if let value {
        alphaComponent(value)
    } else {
        1
    }
}
