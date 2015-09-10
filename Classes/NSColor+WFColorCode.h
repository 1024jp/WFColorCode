//
//  NSColor+WFColorCode.h
//
//  Created by 1024jp on 2014-04-22.

/*
 The MIT License (MIT)
 
 Copyright (c) 2014-2015 1024jp
 
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

@import Cocoa;


/**
 This category on @c NSColor allows creating @c NSColor instance from a CSS color code string, or color code string from a NSColor instance.
 */
@interface NSColor (WFColorCode)

/**
 Color code type
 */
typedef NS_ENUM(NSUInteger, WFColorCodeType) {
    /// Color code is invalid.
    WFColorCodeInvalid,
    
    /// 6-digit hexadecimal color code with # symbol. For example: #ffffff
    WFColorCodeHex,
    
    /// 3-digit hexadecimal color code with # symbol. For example: #fff
    WFColorCodeShortHex,
    
    /// CSS style color code in RGB. For example: rgb(255,255,255)
    WFColorCodeCSSRGB,
    
    /// CSS style color code in RGB with alpha channel. For example: rgba(255,255,255,1)
    WFColorCodeCSSRGBa,
    
    /// CSS style color code in HSL. For example: hsl(0,0%,100%)
    WFColorCodeCSSHSL,
    
    /// CSS style color code in HSL with alpha channel. For example: hsla(0,0%,100%,1)
    WFColorCodeCSSHSLa,
    
    /// CSS style color code with keyrowd. For example: White
    WFColorCodeCSSKeyword,
};


/**
 Creates and returns a @c NSColor object using the given color code. Or returns @c nil if color code is invalid.
 
 Example usage:
 @code
 WFColorCodeType colorCodeType;
 NSColor *whiteColor = [NSColor colorWithColorCode:@"hsla(0,0%,100%,0.5)" codeTypfe:&colorCodeType];
 NSString *hex = [whiteColor colorCodeWithType:WFColorCodeHex];  // => #ffffff
 @endcode
 
 @param colorCode  The CSS3 style color code string. The given code as hex or CSS keyword is case insensitive.
 @param codeType   Upon return, contains the detected color code type.
 @return           The color object.
 */
+ (nullable instancetype)colorWithColorCode:(nonnull NSString *)colorCode codeType:(nullable WFColorCodeType *)codeType;


/**
 Creates and returns a @c NSColor object using the given hex color code. Or returns @c nil if color code is invalid.
 
 Example usage:
 @code
 NSColor *redColor = [NSColor colorWithHex:0xFF0000 alpha:1.0];
 NSString *hex = [redColor colorCodeWithType:WFColorCodeHex];  // => #ff0000
 @endcode
 
 @param hex        The 6-digit hexadecimal color code.
 @param alpha      The opacity value of the color object.
 @return           The color object.
 */
+ (nullable instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;


/**
 Creates and returns a @c <NSString, NSColor> paired dictionary represents all keyword colors specified in CSS3.
 
 @return           The Dcitonary of the stylesheet keyword names and colors pairs. The names are in upper camel case.
 */
+ (nonnull NSDictionary<NSString *, NSColor *> *)stylesheetKeywordColors;


/**
 Returns the receiver’s color code in desired type.
 
 This method works only with objects representing colors in the @c NSCalibratedRGBColorSpace or @c NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @param codeType   The type of color code to format the returned string. You may use one of the types listed in @c WFColorCodeType.
 @return           The color code string formatted in the input type.
 */
- (nullable NSString *)colorCodeWithType:(WFColorCodeType)codeType;

@end




#pragma mark -

/**
 This category on NSColor adds the ability to handle HSL color space.
 */
@interface NSColor (WFHSL)

/**
 Creates and returns a @c NSColor object using the given opacity and HSL components.
 
 Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
 
 @param hue        The hue component of the color object in the HSL color space.
 @param saturation The saturation component of the color object in the HSL color space.
 @param lightness  The lightness component of the color object in the HSL color space.
 @param alpha      The opacity value of the color object.
 @return           The color object.
 */
+ (nonnull instancetype)colorWithDeviceHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;


/**
 Creates and returns a @c NSColor object using the given opacity and HSL components.
 
 Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
 
 @param hue        The hue component of the color object in the HSL color space.
 @param saturation The saturation component of the color object in the HSL color space.
 @param lightness  The lightness component of the color object in the HSL color space.
 @param alpha      The opacity value of the color object.
 @return           The color object.
 */
+ (nonnull instancetype)colorWithCalibratedHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;


/**
 Returns the receiver’s HSL component and opacity values in the respective arguments.
 
 If NULL is passed in as an argument, the method doesn’t set that value. This method works only with objects representing colors in the @c NSCalibratedRGBColorSpace or @c NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @param hue        Upon return, contains the hue component of the color object.
 @param saturation Upon return, contains the saturation component of the color object.
 @param lightness  Upon return, contains the saturation lightness of the color object.
 @param alpha      Upon return, contains the alpha component of the color object.
 */
- (void)getHue:(nullable CGFloat *)hue saturation:(nullable CGFloat *)saturation lightness:(nullable CGFloat *)lightness alpha:(nullable CGFloat *)alpha;


/**
 Returns the saturation component of the HSL color equivalent to the receiver.
 
 This method works only with objects representing colors in the @c NSCalibratedRGBColorSpace or @c NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @return           The color object's saturation component.
 */
- (CGFloat)hslSaturationComponent;


/**
 Returns the lightness component of the HSL color equivalent to the receiver.
 
 This method works only with objects representing colors in the @c NSCalibratedRGBColorSpace or @c NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @return           The color object's lightness component.
 */
- (CGFloat)lightnessComponent;

@end
