//
//  ColorComponents.swift
//  ColorCode
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2026-05-04.
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

enum ColorComponents {
    
    case rgb(Double, Double, Double, alpha: Double = 1)
    case hsl(Double, Double, Double, alpha: Double = 1)
    case hwb(Double, Double, Double, alpha: Double = 1)
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
        
        guard
            (0...0xFFFFFF).contains(hex),
            (0...1).contains(alpha)
        else {
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
                if let components = type.colorComponents(code: code) {
                    (type, components)
                } else {
                    nil
                }
            }).first else { return nil }
        
        type = detectedType
        self = components
    }
}
