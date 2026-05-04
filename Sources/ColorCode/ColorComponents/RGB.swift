//
//  RGB.swift
//  ColorCode
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

struct RGB: ColorComponents {
    
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double = 1
    
    var components: [Double] { [self.red, self.green, self.blue, self.alpha] }
    
    
    var finite: Self {
        
        Self(red: self.red.finite, green: self.green.finite, blue: self.blue.finite, alpha: self.alpha.finite)
    }
    
    
    var hue: Double {
        
        let maxValue = max(self.red, self.green, self.blue)
        let minValue = min(self.red, self.green, self.blue)
        let diff = maxValue - minValue
        
        guard diff > 0 else {
            return 0
        }
        
        var hue: Double = switch maxValue {
        case self.red:
            (self.green - self.blue) / diff + (self.green < self.blue ? 6 : 0)
        case self.green:
            (self.blue - self.red) / diff + 2
        default:
            (self.red - self.green) / diff + 4
        }
        
        hue /= 6
        
        return (hue >= 1) ? hue - 1 : hue
    }
    
    
    var hexValue: Int {
        
        let r = Int((255 * self.red).rounded())
        let g = Int((255 * self.green).rounded())
        let b = Int((255 * self.blue).rounded())
        
        return (r & 0xff) << 16 | (g & 0xff) << 8 | (b & 0xff)
    }
}


extension RGB {
    
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
        
        guard
            (0...0xFFFFFF).contains(hex),
            (0...1).contains(alpha)
        else {
            return nil
        }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = (hex) & 0xff
        
        self.init(red: Double(red) / 255,
                  green: Double(green) / 255,
                  blue: Double(blue) / 255,
                  alpha: alpha)
    }
}


private extension FloatingPoint {
    
    var finite: Self {
        
        self.isFinite ? self : 0
    }
}
