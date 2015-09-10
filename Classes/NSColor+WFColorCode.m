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
    
    NSDictionary<NSString *, NSString *> *patterns = @{@(WFColorCodeHex): @"^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$",
                               @(WFColorCodeShortHex): @"^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$",
                               @(WFColorCodeCSSRGB): @"^rgb\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *\\)$",
                               @(WFColorCodeCSSRGBa): @"^rgba\\( *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9]{1,3}) *, *([0-9.]+) *\\)$",
                               @(WFColorCodeCSSHSL): @"^hsl\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *\\)$",
                               @(WFColorCodeCSSHSLa): @"^hsla\\( *([0-9]{1,3}) *, *([0-9.]+)% *, *([0-9.]+)% *, *([0-9.]+) *\\)$",
                               @(WFColorCodeCSSKeyword): @"^[a-zA-Z]+$",
                               };
    NSTextCheckingResult *result;
    
    // detect code type
    for (NSString *key in patterns) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patterns[key]
                                                                               options:0
                                                                                 error:nil];
        NSArray<NSTextCheckingResult *> *matchs = [regex matchesInString:colorCode options:0 range:codeRange];
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
    switch (detectedCodeType) {
        case WFColorCodeHex: {
            unsigned int r, g, b;
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:1]]] scanHexInt:&r];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:2]]] scanHexInt:&g];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:3]]] scanHexInt:&b];
            return [NSColor colorWithCalibratedRed:((CGFloat)r/255) green:((CGFloat)g/255) blue:((CGFloat)b/255) alpha:1.0];
        }
            
        case WFColorCodeShortHex: {
            unsigned int r, g, b;
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:1]]] scanHexInt:&r];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:2]]] scanHexInt:&g];
            [[NSScanner scannerWithString:[colorCode substringWithRange:[result rangeAtIndex:3]]] scanHexInt:&b];
            return [NSColor colorWithCalibratedRed:((CGFloat)r/15) green:((CGFloat)g/15) blue:((CGFloat)b/15) alpha:1.0];
        }
            
        case WFColorCodeCSSRGB: {
            CGFloat r = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat g = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat b = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            return [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:1.0];
        }
            
        case WFColorCodeCSSRGBa: {
            CGFloat r = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat g = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat b = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            CGFloat a = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:4]] doubleValue];
            return [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:a];
        }
            
        case WFColorCodeCSSHSL: {
            CGFloat h = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat s = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat l = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            return [NSColor colorWithCalibratedHue:h/360 saturation:s/100 lightness:l/100 alpha:1.0];
        }
            
        case WFColorCodeCSSHSLa: {
            CGFloat h = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:1]] doubleValue];
            CGFloat s = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:2]] doubleValue];
            CGFloat l = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:3]] doubleValue];
            CGFloat a = (CGFloat)[[colorCode substringWithRange:[result rangeAtIndex:4]] doubleValue];
            return [NSColor colorWithCalibratedHue:h/360 saturation:s/100 lightness:l/100 alpha:a];
        }
            
        case WFColorCodeCSSKeyword: {
            NSString *lowercase = [colorCode lowercaseString];
            NSDictionary<NSString *, NSNumber *> *map = [NSColor colorKeywordDictionary];
            __block NSColor *color = nil;
            [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([[(NSString *)key lowercaseString] isEqualToString:lowercase]) {
                    NSUInteger hex = [(NSNumber *)obj unsignedIntegerValue];
                    color = [NSColor colorWithHex:hex alpha:1.0];
                    *stop = YES;
                }
            }];
            if (!color && codeType) {
                *codeType = WFColorCodeInvalid;
            }
            return color;
        }
            
        case WFColorCodeInvalid:
            return nil;
    }
}


+ (nullable instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    if (hex > 0xFFFFFF) { return nil; }
    
    CGFloat r = (hex & 0xFF0000) >> 16;
    CGFloat g = (hex & 0x00FF00) >> 8;
    CGFloat b = (hex & 0x0000FF);
    
    return [NSColor colorWithCalibratedRed:r/255 green:g/255 blue:b/255 alpha:alpha];
}


+ (nonnull NSDictionary<NSString *, NSColor *> *)stylesheetKeywordColors
{
    NSDictionary<NSString *, NSNumber *> *map = [NSColor colorKeywordDictionary];
    NSMutableDictionary<NSString *, NSColor *> *dict = [NSMutableDictionary dictionaryWithCapacity:[map count]];
    
    for (NSString *keyword in map) {
        NSUInteger hex = [(NSNumber *)map[keyword] unsignedIntegerValue];
        dict[keyword] = [NSColor colorWithHex:hex alpha:1.0];
    }
    return [dict copy];
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
            
        case WFColorCodeCSSKeyword: {
            NSDictionary<NSString *, NSNumber *> *map = [NSColor colorKeywordDictionary];
            NSNumber *hexNumber = @(((r & 0xff) << 16) + ((g & 0xff) << 8) + (b & 0xff));
            __block NSString *colorCode = nil;
            [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([(NSNumber *)obj isEqualToNumber:hexNumber]) {
                    colorCode = key;
                    *stop = YES;
                }
            }];
            return colorCode;
        }
            
        case WFColorCodeInvalid:
            return nil;
    }
}


#pragma mark Private Methods

+ (nonnull NSDictionary<NSString *, NSNumber *> *)colorKeywordDictionary
{
    return @{// CSS2.1
             @"Black" : @0x000000,
             @"Navy" : @0x000080,
             @"Blue" : @0x0000FF,
             @"Green" : @0x008000,
             @"Lime" : @0x00FF00,
             @"Aqua" : @0x00FFFF,
             @"Teal" : @0x008080,
             @"Maroon" : @0x800000,
             @"Purple" : @0x800080,
             @"Olive" : @0x808000,
             @"Gray" : @0x808080,
             @"Silver" : @0xC0C0C0,
             @"Red" : @0xFF0000,
             @"Fuchsia" : @0xFF00FF,
             @"Orange" : @0xFFA500,
             @"Yellow" : @0xFFFF00,
             @"White" : @0xFFFFFF,
             
             // CSS3
             @"DarkBlue" : @0x00008B,
             @"MediumBlue" : @0x0000CD,
             @"DarkGreen" : @0x006400,
             @"DarkCyan" : @0x008B8B,
             @"DeepSkyBlue" : @0x00BFFF,
             @"DarkTurquoise" : @0x00CED1,
             @"MediumSpringGreen" : @0x00FA9A,
             @"SpringGreen" : @0x00FF7F,
             @"Cyan" : @0x00FFFF,
             @"MidnightBlue" : @0x191970,
             @"DodgerBlue" : @0x1E90FF,
             @"LightSeaGreen" : @0x20B2AA,
             @"ForestGreen" : @0x228B22,
             @"SeaGreen" : @0x2E8B57,
             @"DarkSlateGray" : @0x2F4F4F,
             @"LimeGreen" : @0x32CD32,
             @"MediumSeaGreen" : @0x3CB371,
             @"Turquoise" : @0x40E0D0,
             @"RoyalBlue" : @0x4169E1,
             @"SteelBlue" : @0x4682B4,
             @"DarkSlateBlue" : @0x483D8B,
             @"MediumTurquoise" : @0x48D1CC,
             @"Indigo " : @0x4B0082,
             @"DarkOliveGreen" : @0x556B2F,
             @"CadetBlue" : @0x5F9EA0,
             @"CornflowerBlue" : @0x6495ED,
             @"RebeccaPurple" : @0x663399,
             @"MediumAquaMarine" : @0x66CDAA,
             @"DimGray" : @0x696969,
             @"SlateBlue" : @0x6A5ACD,
             @"OliveDrab" : @0x6B8E23,
             @"SlateGray" : @0x708090,
             @"LightSlateGray" : @0x778899,
             @"MediumSlateBlue" : @0x7B68EE,
             @"LawnGreen" : @0x7CFC00,
             @"Chartreuse" : @0x7FFF00,
             @"Aquamarine" : @0x7FFFD4,
             @"SkyBlue" : @0x87CEEB,
             @"LightSkyBlue" : @0x87CEFA,
             @"BlueViolet" : @0x8A2BE2,
             @"DarkRed" : @0x8B0000,
             @"DarkMagenta" : @0x8B008B,
             @"SaddleBrown" : @0x8B4513,
             @"DarkSeaGreen" : @0x8FBC8F,
             @"LightGreen" : @0x90EE90,
             @"MediumPurple" : @0x9370DB,
             @"DarkViolet" : @0x9400D3,
             @"PaleGreen" : @0x98FB98,
             @"DarkOrchid" : @0x9932CC,
             @"YellowGreen" : @0x9ACD32,
             @"Sienna" : @0xA0522D,
             @"Brown" : @0xA52A2A,
             @"DarkGray" : @0xA9A9A9,
             @"LightBlue" : @0xADD8E6,
             @"GreenYellow" : @0xADFF2F,
             @"PaleTurquoise" : @0xAFEEEE,
             @"LightSteelBlue" : @0xB0C4DE,
             @"PowderBlue" : @0xB0E0E6,
             @"FireBrick" : @0xB22222,
             @"DarkGoldenRod" : @0xB8860B,
             @"MediumOrchid" : @0xBA55D3,
             @"RosyBrown" : @0xBC8F8F,
             @"DarkKhaki" : @0xBDB76B,
             @"MediumVioletRed" : @0xC71585,
             @"IndianRed " : @0xCD5C5C,
             @"Peru" : @0xCD853F,
             @"Chocolate" : @0xD2691E,
             @"Tan" : @0xD2B48C,
             @"LightGray" : @0xD3D3D3,
             @"Thistle" : @0xD8BFD8,
             @"Orchid" : @0xDA70D6,
             @"GoldenRod" : @0xDAA520,
             @"PaleVioletRed" : @0xDB7093,
             @"Crimson" : @0xDC143C,
             @"Gainsboro" : @0xDCDCDC,
             @"Plum" : @0xDDA0DD,
             @"BurlyWood" : @0xDEB887,
             @"LightCyan" : @0xE0FFFF,
             @"Lavender" : @0xE6E6FA,
             @"DarkSalmon" : @0xE9967A,
             @"Violet" : @0xEE82EE,
             @"PaleGoldenRod" : @0xEEE8AA,
             @"LightCoral" : @0xF08080,
             @"Khaki" : @0xF0E68C,
             @"AliceBlue" : @0xF0F8FF,
             @"HoneyDew" : @0xF0FFF0,
             @"Azure" : @0xF0FFFF,
             @"SandyBrown" : @0xF4A460,
             @"Wheat" : @0xF5DEB3,
             @"Beige" : @0xF5F5DC,
             @"WhiteSmoke" : @0xF5F5F5,
             @"MintCream" : @0xF5FFFA,
             @"GhostWhite" : @0xF8F8FF,
             @"Salmon" : @0xFA8072,
             @"AntiqueWhite" : @0xFAEBD7,
             @"Linen" : @0xFAF0E6,
             @"LightGoldenRodYellow" : @0xFAFAD2,
             @"OldLace" : @0xFDF5E6,
             @"Magenta" : @0xFF00FF,
             @"DeepPink" : @0xFF1493,
             @"OrangeRed" : @0xFF4500,
             @"Tomato" : @0xFF6347,
             @"HotPink" : @0xFF69B4,
             @"Coral" : @0xFF7F50,
             @"DarkOrange" : @0xFF8C00,
             @"LightSalmon" : @0xFFA07A,
             @"LightPink" : @0xFFB6C1,
             @"Pink" : @0xFFC0CB,
             @"Gold" : @0xFFD700,
             @"PeachPuff" : @0xFFDAB9,
             @"NavajoWhite" : @0xFFDEAD,
             @"Moccasin" : @0xFFE4B5,
             @"Bisque" : @0xFFE4C4,
             @"MistyRose" : @0xFFE4E1,
             @"BlanchedAlmond" : @0xFFEBCD,
             @"PapayaWhip" : @0xFFEFD5,
             @"LavenderBlush" : @0xFFF0F5,
             @"SeaShell" : @0xFFF5EE,
             @"Cornsilk" : @0xFFF8DC,
             @"LemonChiffon" : @0xFFFACD,
             @"FloralWhite" : @0xFFFAF0,
             @"Snow" : @0xFFFAFA,
             @"LightYellow" : @0xFFFFE0,
             @"Ivory" : @0xFFFFF0,
             };
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
