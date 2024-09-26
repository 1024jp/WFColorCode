//
//  HSL.swift
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

/// Calculate the correspondent saturation in HSB color space from the saturation and lightness in HSL color space.
/// 
/// - Parameters:
///   - saturation: The saturation value in HSL color space.
///   - lightness: The lightness value in HSL color space.
/// - Returns: A saturation value in HSB color space.
func hsbSaturation<Value: BinaryFloatingPoint>(saturation: Value, lightness: Value) -> Value {
    
    let brightness = hsbBrightness(saturation: saturation, lightness: lightness)
    
    return 2 * (1 - lightness / brightness)
}


/// Calculate the correspondent brightness in HSB color space from the saturation and lightness in HSL color space.
///
/// - Parameters:
///   - saturation: The saturation value in HSL color space.
///   - lightness: The lightness value in HSL color space.
/// - Returns: A brightness value in HSB color space.
func hsbBrightness<Value: BinaryFloatingPoint>(saturation: Value, lightness: Value) -> Value {
    
    lightness + saturation * min(lightness, 1 - lightness)
}
