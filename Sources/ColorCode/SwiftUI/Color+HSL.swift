//
//  Color+HSL.swift
//
//  Created by 1024jp on 2021-05-08.

/*
 The MIT License (MIT)
 
 © 2014-2021 1024jp
 
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

import SwiftUI

/// This extension on Color adds the ability to handle HSL color space.
public extension Color {
    
    /// Creates and returns a `Color` using the given opacity and HSL components.
    ///
    /// Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the color object in the HSL color space.
    ///   - saturation: The saturation component of the color object in the HSL color space.
    ///   - lightness: The lightness component of the color object in the HSL color space.
    ///   - opacity: The opacity value of the color object.
     init(hue: Double, saturation: Double, lightness: Double, opacity: Double = 1.0) {
        
        self.init(hue: hue,
                  saturation: hsbSaturation(saturation: saturation, lightness: lightness),
                  brightness: hsbBrightness(saturation: saturation, lightness: lightness),
                  opacity: opacity)
    }
    
}
