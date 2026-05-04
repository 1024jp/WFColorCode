//
//  NSColor+HSL.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2014-04-22.
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

#if canImport(AppKit)
public import AppKit.NSColor

/// This extension on NSColor adds the ability to handle HSL color space.
public extension NSColor {
    
    /// Creates and returns a `NSColor` object using the given opacity and HSL components.
    ///
    /// Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the color object in the HSL color space.
    ///   - saturation: The saturation component of the color object in the HSL color space.
    ///   - lightness: The lightness component of the color object in the HSL color space.
    ///   - alpha: The opacity value of the color object.
    convenience init(deviceHue hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1.0) {
        
        let hsb = HSL(hue: hue, saturation: saturation, lightness: lightness).hsb
        
        self.init(deviceHue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: alpha)
    }
    
    
    /// Creates and returns an `NSColor` object using the given opacity and HSL components.
    ///
    /// Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the color object in the HSL color space.
    ///   - saturation: The saturation component of the color object in the HSL color space.
    ///   - lightness: The lightness component of the color object in the HSL color space.
    ///   - alpha: The opacity value of the color object.
    convenience init(calibratedHue hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1.0) {
        
        let hsb = HSL(hue: hue, saturation: saturation, lightness: lightness).hsb
        
        self.init(calibratedHue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: alpha)
    }
    
    
    /// Returns the receiver’s HSL component and opacity values in the respective arguments.
    ///
    /// If `nil` is passed in as an argument, the method doesn’t set that value.
    /// This method works only with objects representing colors in the `NSColorSpace.genericRGB` or
    /// `NSColorSpace.deviceRGB` color space. Sending it to other objects raises an exception.
    ///
    /// - Parameters:
    ///   - hue: Upon return, contains the hue component of the color object.
    ///   - saturation: Upon return, contains the saturation component of the color object.
    ///   - lightness: Upon return, contains the saturation lightness of the color object.
    ///   - alpha: Upon return, contains the alpha component of the color object.
    @available(*, deprecated, renamed: "hslComponents")
    func getHue(hue: UnsafeMutablePointer<CGFloat>?, saturation: UnsafeMutablePointer<CGFloat>?, lightness: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) {
        
        let hsl = self.rgb.hsl
        
        unsafe hue?.pointee = hsl.hue
        unsafe saturation?.pointee = hsl.saturation
        unsafe lightness?.pointee = hsl.lightness
        unsafe alpha?.pointee = hsl.alpha
    }
    
    
    /// The HSL component and opacity values of the receiver.
    ///
    /// This property returns `nil` if the receiver is not in an RGB color space and cannot be converted to the `NSColorSpace.genericRGB` color space.
    var hslComponents: (hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat)? {
        
        let color: NSColor? = switch self.colorSpace {
        case .genericRGB, .deviceRGB:
            self
        default:
            self.usingColorSpace(.genericRGB)
        }
        
        guard let color else {
            return nil
        }
        
        let hsl = color.rgb.hsl
        
        return (CGFloat(hsl.hue), CGFloat(hsl.saturation), CGFloat(hsl.lightness), CGFloat(hsl.alpha))
    }
    
    
    /// The saturation component of the HSL color equivalent to the receiver.
    ///
    /// Access this property only for colors in the `NSColorSpace.genericRGB` or
    /// `NSColorSpace.deviceRGB` color space. Sending it to other objects raises an exception.
    var hslSaturationComponent: CGFloat {
        
        self.rgb.hsl.saturation
    }
    
    
    /// The lightness component of the HSL color equivalent to the receiver.
    ///
    /// Access this property only for colors in the `NSColorSpace.genericRGB` or
    /// `NSColorSpace.deviceRGB` color space. Sending it to other objects raises an exception.
    var lightnessComponent: CGFloat {
        
        self.rgb.hsl.lightness
    }
}
#endif
