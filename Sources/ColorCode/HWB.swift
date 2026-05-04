//
//  HWB.swift
//
//  Created by 1024jp on 2026-05-04.

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

/// Calculate the correspondent RGB components from the hue, whiteness, and blackness in HWB color space.
///
/// - Parameters:
///   - hue: The hue value in HWB color space between `0.0` and `1.0`.
///   - whiteness: The whiteness value in HWB color space between `0.0` and `1.0`.
///   - blackness: The blackness value in HWB color space between `0.0` and `1.0`.
/// - Returns: The RGB components.
func rgbComponents<Value: BinaryFloatingPoint>(hue: Value, whiteness: Value, blackness: Value) -> (red: Value, green: Value, blue: Value) {
    
    if whiteness + blackness >= 1 {
        let gray = whiteness / (whiteness + blackness)
        return (gray, gray, gray)
    }
    
    func channel(_ value: Value) -> Value {
        
        let k = (value + hue * 12).truncatingRemainder(dividingBy: 12)
        let a: Value = 0.5
        
        return 0.5 - a * max(-1, min(k - 3, 9 - k, 1))
    }
    
    let factor = 1 - whiteness - blackness
    
    return (channel(0) * factor + whiteness,
            channel(8) * factor + whiteness,
            channel(4) * factor + whiteness)
}


/// Calculate the correspondent HWB components from the red, green, and blue components in RGB color space.
///
/// - Parameters:
///   - red: The red value in RGB color space between `0.0` and `1.0`.
///   - green: The green value in RGB color space between `0.0` and `1.0`.
///   - blue: The blue value in RGB color space between `0.0` and `1.0`.
/// - Returns: The HWB components.
func hwbComponents<Value: BinaryFloatingPoint>(red: Value, green: Value, blue: Value) -> (hue: Value, whiteness: Value, blackness: Value) {
    
    let maxValue = max(red, green, blue)
    let minValue = min(red, green, blue)
    let diff = maxValue - minValue
    var hue: Value = 0
    
    if diff > 0 {
        hue = switch maxValue {
        case red:
            (green - blue) / diff + (green < blue ? 6 : 0)
        case green:
            (blue - red) / diff + 2
        default:
            (red - green) / diff + 4
        }
        
        hue /= 6
        if hue >= 1 {
            hue -= 1
        }
    }
    
    return (hue, minValue, 1 - maxValue)
}
