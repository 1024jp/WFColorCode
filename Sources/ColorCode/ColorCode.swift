//
//  ColorCode.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2026-05-05.
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

extension RGB {
    
    /// Returns the color code formatted in the given type.
    ///
    /// - Parameter type: The type of color code to format.
    /// - Returns: The formatted color code, or `nil` if this RGB value cannot be represented in the given type.
    func colorCode(type: ColorCodeType) -> String? {
        
        switch type {
        case .hex:
            self.hex()
        case .hexWithAlpha:
            self.hex(withAlpha: true)
        case .shortHex:
            self.shortHex()
        case .shortHexWithAlpha:
            self.shortHex(withAlpha: true)
        case .cssRGB:
            self.cssFormat()
        case .cssRGBa:
            self.cssFormat(withAlpha: true)
        case .cssHSL:
            self.hsl.cssFormat()
        case .cssHSLa:
            self.hsl.cssFormat(withAlpha: true)
        case .cssHWB:
            self.hwb.cssFormat()
        case .cssHWBWithAlpha:
            self.hwb.cssFormat(withAlpha: true)
        case .cssKeyword:
            KeywordColor(value: self.hexValue)?.keyword
        }
    }
    
    
    /// Returns a hexadecimal color code.
    ///
    /// - Parameter withAlpha: Whether to include the alpha component.
    /// - Returns: The formatted hexadecimal color code.
    func hex(withAlpha: Bool = false) -> String {
        
        // The value formatted as a two-digit lowercase hexadecimal string.
        func twoDigitHex(_ value: Int) -> String {
            
            let string = String(value, radix: 16)
            return (string.count == 1) ? "0" + string : string
        }
        
        let bytes = self.byteComponents
        let colorBytes = withAlpha ? bytes : bytes.dropLast()

        return "#" + colorBytes.map(twoDigitHex).joined()
    }
    
    
    /// Returns a shorthand hexadecimal color code.
    ///
    /// - Parameter withAlpha: Whether to include the alpha component.
    /// - Returns: The formatted shorthand hexadecimal color code, or `nil` if the color cannot be represented in shorthand form.
    func shortHex(withAlpha: Bool = false) -> String? {
        
        let bytes = withAlpha ? self.byteComponents : self.byteComponents.dropLast()
        
        guard bytes.allSatisfy({ $0.isMultiple(of: 17) }) else {
            return nil
        }
        
        return "#" + bytes.map { String($0 / 17, radix: 16) }.joined()
    }
    
    
    /// Returns a CSS RGB color code.
    ///
    /// - Parameter withAlpha: Whether to include the alpha component.
    /// - Returns: The formatted CSS RGB color code.
    func cssFormat(withAlpha: Bool = false) -> String {
        
        let bytes = self.byteComponents
        let red = bytes[0]
        let green = bytes[1]
        let blue = bytes[2]
        
        return withAlpha
            ? "rgba(\(red),\(green),\(blue),\(self.alpha.cssAlphaString))"
            : "rgb(\(red),\(green),\(blue))"
    }
}


extension HSL {
    
    /// Returns a CSS HSL color code.
    ///
    /// - Parameter withAlpha: Whether to include the alpha component.
    /// - Returns: The formatted CSS HSL color code.
    func cssFormat(withAlpha: Bool = false) -> String {
        
        let h = (self.saturation > 0) ? Int((360 * self.hue).rounded()) : 0
        let s = Int((100 * self.saturation).rounded())
        let l = Int((100 * self.lightness).rounded())
        
        return withAlpha
            ? "hsla(\(h),\(s)%,\(l)%,\(self.alpha.cssAlphaString))"
            : "hsl(\(h),\(s)%,\(l)%)"
    }
}


extension HWB {
    
    /// Returns a CSS HWB color code.
    ///
    /// - Parameter withAlpha: Whether to include the alpha component.
    /// - Returns: The formatted CSS HWB color code.
    func cssFormat(withAlpha: Bool = false) -> String {
        
        let h = Int((360 * self.hue).rounded())
        let w = Int((100 * self.whiteness).rounded())
        let b = Int((100 * self.blackness).rounded())
        
        return withAlpha
            ? "hwb(\(h) \(w)% \(b)% / \(self.alpha.cssAlphaString))"
            : "hwb(\(h) \(w)% \(b)%)"
    }
}


private extension Double {
    
    /// The value formatted as a CSS alpha component.
    var cssAlphaString: String {
        
        self.formatted(.number
            .precision(.fractionLength(0...2))
            .locale(Locale(identifier: "en_US_POSIX")))
    }
}
