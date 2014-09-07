//
//  NSColor+WFColorCode.h
//
//  Created by 1024jp on 2014-04-22.

/*
 The MIT License (MIT)
 
 Copyright (c) 2014 1024jp
 
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


@interface NSColor (WFColorCode)

/// color code type
typedef NS_ENUM(NSUInteger, WFColorCodeType) {
    WFColorCodeInvalid,   // nil
    WFColorCodeHex,       // #ffffff
    WFColorCodeShortHex,  // #fff
    WFColorCodeCSSRGB,    // rgb(255,255,255)
    WFColorCodeCSSRGBa,   // rgba(255,255,255,1)
    WFColorCodeCSSHSL,    // hsl(0,0%,100%)
    WFColorCodeCSSHSLa    // hsla(0,0%,100%,1)
};


/** Creates and returns an NSColor object using the given color code. Or returns nil if color code is invalid.
 
 @param colorCode  The CSS3 style color code string.
 @param codeType   Upon return, contains the detected color code type.
 @return           The color object.
 */
+ (NSColor *)colorWithColorCode:(NSString *)colorCode codeType:(WFColorCodeType *)codeType;


/** Returns the receiver’s color code in desired type.
 
This method works only with objects representing colors in the NSCalibratedRGBColorSpace or NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @param codeType   The type of color code to format the returned string. You may use one of the types listed in WFColorCodeType.
 @return           The color code string formatted in the input type.
 */
- (NSString *)colorCodeWithType:(WFColorCodeType)codeType;

@end




#pragma mark -

@interface NSColor (WFHSL)

/** Creates and returns an NSColor object using the given opacity and HSL components.
 
 Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
 
 @param hue        The hue component of the color object in the HSL color space.
 @param saturation The saturation component of the color object in the HSL color space.
 @param lightness  The lightness component of the color object in the HSL color space.
 @param alpha      The opacity value of the color object.
 @return           The color object.
 */
+ (NSColor *)colorWithDeviceHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;


/** Creates and returns an NSColor object using the given opacity and HSL components.
 
 Values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
 
 @param hue        The hue component of the color object in the HSL color space.
 @param saturation The saturation component of the color object in the HSL color space.
 @param lightness  The lightness component of the color object in the HSL color space.
 @param alpha      The opacity value of the color object.
 @return           The color object.
 */
+ (NSColor *)colorWithCalibratedHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;


/** Returns the receiver’s HSL component and opacity values in the respective arguments.
 
 If NULL is passed in as an argument, the method doesn’t set that value. This method works only with objects representing colors in the NSCalibratedRGBColorSpace or NSDeviceRGBColorSpace color space. Sending it to other objects raises an exception.
 
 @param hue        Upon return, contains the hue component of the color object.
 @param saturation Upon return, contains the saturation component of the color object.
 @param lightness  Upon return, contains the saturation lightness of the color object.
 @param alpha      Upon return, contains the alpha component of the color object.
 */
- (void)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha;

@end
