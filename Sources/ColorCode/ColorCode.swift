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
    
    
    func hex(withAlpha: Bool = false) -> String {
        
        let r = Int((255 * self.red).rounded())
        let g = Int((255 * self.green).rounded())
        let b = Int((255 * self.blue).rounded())
        let alpha = Int((255 * self.alpha).rounded())
        
        /// The the value formatted as a two-digit lowercase hexadecimal string.
        func twoDigitHex(_ value: Int) -> String {
            
            let string = String(value, radix: 16)
            return (string.count == 1) ? "0" + string : string
        }
        
        return withAlpha
            ? "#\(twoDigitHex(r))\(twoDigitHex(g))\(twoDigitHex(b))\(twoDigitHex(alpha))"
            : "#\(twoDigitHex(r))\(twoDigitHex(g))\(twoDigitHex(b))"
    }
    
    
    func shortHex(withAlpha: Bool = false) -> String? {
        
        let r = Int((255 * self.red).rounded())
        let g = Int((255 * self.green).rounded())
        let b = Int((255 * self.blue).rounded())
        let alpha = Int((255 * self.alpha).rounded())
        
        guard
            r.isMultiple(of: 17),
            g.isMultiple(of: 17),
            b.isMultiple(of: 17)
        else { return nil }
        
        let red = String(r / 17, radix: 16)
        let green = String(g / 17, radix: 16)
        let blue = String(b / 17, radix: 16)
        
        if withAlpha {
            guard alpha.isMultiple(of: 17) else {
                return nil
            }
            let alphaDigit = String(alpha / 17, radix: 16)
            
            return "#\(red)\(green)\(blue)\(alphaDigit)"
        } else {
            return "#\(red)\(green)\(blue)"
        }
    }
    
    
    func cssFormat(withAlpha: Bool = false) -> String {
        
        let r = Int((255 * self.red).rounded())
        let g = Int((255 * self.green).rounded())
        let b = Int((255 * self.blue).rounded())
        
        return withAlpha
            ? "rgba(\(r),\(g),\(b),\(self.alpha.cssAlphaString))"
            : "rgb(\(r),\(g),\(b))"
    }
}


extension HSL {
    
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
