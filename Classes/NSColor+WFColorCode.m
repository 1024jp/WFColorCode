//
//  NSColor+WFColorCode.m
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

#import "NSColor+WFColorCode.h"


@implementation NSColor (WFColorCode)

#pragma mark Public Methods

+ (nullable instancetype)colorWithColorCode:(nonnull NSString *)colorCode
                                   codeType:(nullable WFColorCodeType *)codeType
{
    colorCode = [colorCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSRange codeRange = NSMakeRange(0, [colorCode length]);
    WFColorCodeType detectedCodeType = WFColorCodeInvalid;
    
    NSDictionary *patterns = @{@(WFColorCodeHex): @"^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$",
                               @(WFColorCodeShortHex): @"^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$",
                               @(WFColorCodeCSSRGB): @"^rgb\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\\)$",
                               @(WFColorCodeCSSRGBa): @"^rgba\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9.]+) *\\)$",
                               @(WFColorCodeCSSHSL): @"^hsl\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\\)$",
                               @(WFColorCodeCSSHSLa): @"^hsla\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *, *([0-9.]+) *\\)$"
                               };
    NSTextCheckingResult *result;
    
    // detect code type
    for (NSString *key in patterns) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patterns[key]
                                                                               options:0
                                                                                 error:nil];
        NSArray *matchs = [regex matchesInString:colorCode options:0 range:codeRange];
        if ([matchs count] == 1) {
            detectedCodeType = [key integerValue];
            result = matchs[0];
            break;
        }
    }
    
    if (codeType) {
        *codeType = detectedCodeType;
    }
    
    // create color from result
    NSColor *color;
    switch (detectedCodeType) {
        case WFColorCodeHex: {
            unsigned int r, g, b;
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:1]]] scanHexInt:&r];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:2]]] scanHexInt:&g];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:3]]] scanHexInt:&b];
            color = [NSColor colorWithCalibratedRed:((CGFloat)r/255) green:((CGFloat)g/255) blue:((CGFloat)b/255) alpha:1.0];
        } break;
            
        case WFColorCodeShortHex: {
            unsigned int r, g, b;
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:1]]] scanHexInt:&r];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:2]]] scanHexInt:&g];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:3]]] scanHexInt:&b];
            color = [NSColor colorWithCalibratedRed:((CGFloat)r/15) green:((CGFloat)g/15) blue:((CGFloat)b/15) alpha:1.0];
        } break;
            
        case WFColorCodeCSSRGB: {
            CGFloat r = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat g = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat b = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            color = [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:1.0];
        } break;
            
        case WFColorCodeCSSRGBa: {
            CGFloat r = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat g = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat b = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            CGFloat a = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:4]] doubleValue];
            color = [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:a];
        } break;
            
        case WFColorCodeCSSHSL: {
            CGFloat h = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat s = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat l = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            color = [NSColor colorWithCalibratedHue:h/360 saturation:s/100 lightness:l/100 alpha:1.0];
        } break;
            
        case WFColorCodeCSSHSLa: {
            CGFloat h = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat s = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat l = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            CGFloat a = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:4]] doubleValue];
            color = [NSColor colorWithCalibratedHue:h/360 saturation:s/100 lightness:l/100 alpha:a];
        } break;
            
        case WFColorCodeInvalid:
            color = nil;
            break;
    }
    
    return color;
}


+ (nullable instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    if (hex > 0xFFFFFF) { return nil; }
    
    CGFloat r = (hex & 0xFF0000) >> 16;
    CGFloat g = (hex & 0x00FF00) >> 8;
    CGFloat b = (hex & 0x0000FF);
    
    return [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:alpha];
}


- (nullable NSString *)colorCodeWithType:(WFColorCodeType)codeType
{
    int r = (int)roundf(255 * [self redComponent]);
    int g = (int)roundf(255 * [self greenComponent]);
    int b = (int)roundf(255 * [self blueComponent]);
    double alpha = (double)[self alphaComponent];
    
    switch (codeType) {
        case WFColorCodeHex:
            return [NSString stringWithFormat:@"#%02x%02x%02x", r, g, b];
            
        case WFColorCodeShortHex:
            return [NSString stringWithFormat:@"#%1x%1x%1x", r/16, g/16, b/16];
            
        case WFColorCodeCSSRGB:
            return [NSString stringWithFormat:@"rgb(%d,%d,%d)", r, g, b];
            
        case WFColorCodeCSSRGBa:
            return [NSString stringWithFormat:@"rgba(%d,%d,%d,%g)", r, g, b, alpha];
            
        case WFColorCodeCSSHSL:
        case WFColorCodeCSSHSLa: {
            CGFloat hue, saturation, lightness, alpha;
            [self getHue:&hue saturation:&saturation lightness:&lightness alpha:&alpha];
            
            int h = (saturation == 0) ? 0 : (int)roundf(360 * hue);
            int s = (int)roundf(100 * saturation);
            int l = (int)roundf(100 * lightness);
            
            if (codeType == WFColorCodeCSSHSLa) {
                return [NSString stringWithFormat:@"hsla(%d,%d%%,%d%%,%g)", h, s, l, alpha];
            } else {
                return [NSString stringWithFormat:@"hsl(%d,%d%%,%d%%)", h, s, l];
            }
        }
            
        case WFColorCodeInvalid:
            return nil;
    }
}

@end




#pragma mark -

@implementation NSColor (WFHSL)

#pragma mark Public Methods

+ (nonnull instancetype)colorWithDeviceHue:(CGFloat)hue
                                saturation:(CGFloat)saturation
                                 lightness:(CGFloat)lightness
                                     alpha:(CGFloat)alpha
{
    return [NSColor colorWithDeviceHue:hue
                            saturation:hsbSaturation(saturation, lightness)
                            brightness:hsbBrightness(saturation, lightness)
                                 alpha:alpha];
}


+ (nonnull instancetype)colorWithCalibratedHue:(CGFloat)hue
                                    saturation:(CGFloat)saturation
                                     lightness:(CGFloat)lightness
                                         alpha:(CGFloat)alpha
{
    return [NSColor colorWithCalibratedHue:hue
                                saturation:hsbSaturation(saturation, lightness)
                                brightness:hsbBrightness(saturation, lightness)
                                     alpha:alpha];
}


- (void)getHue:(nullable CGFloat *)hue
    saturation:(nullable CGFloat *)saturation
     lightness:(nullable CGFloat *)lightness
         alpha:(nullable CGFloat *)alpha
{
    if (hue)        { *hue        = [self hueComponent]; }
    if (saturation) { *saturation = [self hslSaturationComponent]; }
    if (lightness)  { *lightness  = [self lightnessComponent]; }
    if (alpha)      { *alpha      = [self alphaComponent]; }
}


- (CGFloat)hslSaturationComponent
{
    CGFloat max = MAX(MAX([self redComponent], [self greenComponent]), [self blueComponent]);
    CGFloat min = MIN(MIN([self redComponent], [self greenComponent]), [self blueComponent]);
    CGFloat diff = max - min;
    
    CGFloat saturation = ([self lightnessComponent] > 0.5) ? diff / (2 - max - min) : diff / (max + min);
    
    if (isnan(saturation) ||
        ([self saturationComponent] < 0.00001 && [self brightnessComponent] < 9.9999))
    {
        saturation = 0;
    }
    
    return saturation;
}


- (CGFloat)lightnessComponent
{
    CGFloat max = MAX(MAX([self redComponent], [self greenComponent]), [self blueComponent]);
    CGFloat min = MIN(MIN([self redComponent], [self greenComponent]), [self blueComponent]);
    
    return (max + min) / 2;
}


#pragma mark Private Functions

CGFloat hsbSaturation(CGFloat hslSaturation, CGFloat hslLightness)
{
    hslSaturation *= (hslLightness < 0.5) ? hslLightness : 1 - hslLightness;
    
    return (2 * hslSaturation / (hslLightness + hslSaturation));
}


CGFloat hsbBrightness(CGFloat hslSaturation, CGFloat hslLightness)
{
    hslSaturation *= (hslLightness < 0.5) ? hslLightness : 1 - hslLightness;
    
    return (hslLightness + hslSaturation);
}

@end
