//
//  ColorCode.swift
//
//  Created by 1024jp on 2021-05-08.

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

public enum ColorCodeType: Int, CaseIterable, Sendable {
    
    /// 6-digit hexadecimal color code with # symbol. For example: `#ffffff`
    case hex = 1
    
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
    init?(hex: Int) {
        
        guard (0...0xFFFFFF).contains(hex) else {
            return nil
        }
        
        let r = (hex >> 16) & 0xff
        let g = (hex >> 8) & 0xff
        let b = (hex) & 0xff
        
        self = .rgb(Double(r) / 255, Double(g) / 255, Double(b) / 255)
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
        
        // detect code type
        guard let (detectedType, result) = ColorCodeType.allCases.lazy
                .compactMap({ type -> (ColorCodeType, NSTextCheckingResult)? in
                    let pattern: String = {
                        switch type {
                        case .hex:
                            return "^#[0-9a-fA-F]{6}$"
                        case .shortHex:
                            return "^#[0-9a-fA-F]{3}$"
                        case .cssRGB:
                            return "^rgb\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\\)$"
                        case .cssRGBa:
                            return "^rgba\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9.]+) *\\)$"
                        case .cssHSL:
                            return "^hsl\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\\)$"
                        case .cssHSLa:
                            return "^hsla\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *, *([0-9.]+) *\\)$"
                        case .cssKeyword:
                            return "^[a-zA-Z]+$"
                        }
                    }()
                    let regex = try! NSRegularExpression(pattern: pattern)
                    
                    guard let match = regex.firstMatch(in: code, range: NSRange(0..<code.utf16.count)) else {
                        return nil
                    }
                    return (type, match)
                    
                }).first else { return nil }
        
        // create color from result
        switch detectedType {
        case .hex:
            let hex = Int(code.dropFirst(), radix: 16)!
            self.init(hex: hex)
            
        case .shortHex:
            let hex = Int(code.dropFirst(), radix: 16)!
            let r = (hex >> 8) & 0xff
            let g = (hex >> 4) & 0xff
            let b = (hex) & 0xff
            self = .rgb(Double(r) / 15, Double(g) / 15, Double(b) / 15)
            
        case .cssRGB:
            guard
                let r = result.double(in: code, at: 1),
                let g = result.double(in: code, at: 2),
                let b = result.double(in: code, at: 3)
            else { return nil }
            self = .rgb(r / 255, g / 255, b / 255)
            
        case .cssRGBa:
            guard
                let r = result.double(in: code, at: 1),
                let g = result.double(in: code, at: 2),
                let b = result.double(in: code, at: 3),
                let a = result.double(in: code, at: 4)
            else { return nil }
            self = .rgb(r / 255, g / 255, b / 255, alpha: a)
            
        case .cssHSL:
            guard
                let h = result.double(in: code, at: 1),
                let s = result.double(in: code, at: 2),
                let l = result.double(in: code, at: 3)
            else { return nil }
            self = .hsl(h / 360, s / 100, l / 100)
            
        case .cssHSLa:
            guard
                let h = result.double(in: code, at: 1),
                let s = result.double(in: code, at: 2),
                let l = result.double(in: code, at: 3),
                let a = result.double(in: code, at: 4)
            else { return nil }
            self = .hsl(h / 360, s / 100, l / 100, alpha: a)
            
        case .cssKeyword:
            guard
                let color = KeywordColor(keyword: code)
            else { return nil }
            self.init(hex: color.value)
        }
        
        type = detectedType
    }
    
}



private extension NSTextCheckingResult {
    
    func double(in string: String, at index: Int) -> Double? {
        
        let range = Range(self.range(at: index), in: string)!
        
        return Double(string[range])
    }
    
}
