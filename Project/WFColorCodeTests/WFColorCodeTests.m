//
//  WFColorCodeTests.m
//  WFColorCode
//
//  Created by 1024jp on 2014-09-02.

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
@import XCTest;
#import "NSColor+WFColorCode.h"

@interface WFColorCodeTests : XCTestCase

@end


@implementation WFColorCodeTests

- (void)testColorCreation
{
    NSColor *whiteColor = [[NSColor whiteColor] colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    WFColorCodeType type;
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"#ffffff" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeHex);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"#fff" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeShortHex);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"rgb(255,255,255)" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeCSSRGB);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"rgba(255,255,255,1)" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeCSSRGBa);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"hsl(0,0%,100%)" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeCSSHSL);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"hsla(0,0%,100%,1)" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeCSSHSLa);
    
    XCTAssertEqualObjects([NSColor colorWithColorCode:@"White" codeType:&type], whiteColor);
    XCTAssertEqual(type, WFColorCodeCSSKeyword);
    
    XCTAssertNil([NSColor colorWithColorCode:@"" codeType:&type]);
    XCTAssertEqual(type, WFColorCodeInvalid);
    
    XCTAssertNil([NSColor colorWithColorCode:@"foobar" codeType:&type]);
    XCTAssertEqual(type, WFColorCodeInvalid);
}


- (void)testWhite
{
    NSColor *color = [[NSColor whiteColor] colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    XCTAssertThrows([[NSColor whiteColor] colorCodeWithType:WFColorCodeHex]);
    
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeHex], @"#ffffff");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeShortHex], @"#fff");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSRGB], @"rgb(255,255,255)");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSRGBa], @"rgba(255,255,255,1)");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSHSL], @"hsl(0,0%,100%)");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSHSLa], @"hsla(0,0%,100%,1)");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSKeyword], @"White");
    XCTAssertNil([color colorCodeWithType:WFColorCodeInvalid]);
}


- (void)testHSLaColorCode
{
    NSString *colorCode = @"hsla(203,10%,20%,0.3)";
    WFColorCodeType colorCodeType;
    NSColor *color = [NSColor colorWithColorCode:colorCode codeType:&colorCodeType];
    
    XCTAssertEqual(colorCodeType, WFColorCodeCSSHSLa);
    XCTAssertEqualObjects([color colorCodeWithType:colorCodeType], colorCode);
}


- (void)testHexColorCode
{
    WFColorCodeType colorCodeType;
    NSColor *color = [NSColor colorWithColorCode:@"#0066aa" codeType:&colorCodeType];
    
    XCTAssertEqual(colorCodeType, WFColorCodeHex);
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeHex], @"#0066aa");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeShortHex], @"#06a");
}


- (void)testHSL
{
    CGFloat hue, saturation, lightness, alpha;
    NSColor *color = [NSColor colorWithDeviceHue:0.1 saturation:0.2 lightness:0.3 alpha:0.4];
    
    [color getHue:&hue saturation:&saturation lightness:&lightness alpha:&alpha];
    
    XCTAssertEqualWithAccuracy(hue, 0.1, 3);
    XCTAssertEqualWithAccuracy(saturation, 0.2, 3);
    XCTAssertEqualWithAccuracy(lightness, 0.3, 3);
    XCTAssertEqual(alpha, 0.4);
}


- (void)testHex
{
    NSColor *color = [NSColor colorWithHex:0xFF6600 alpha:1.0];
    
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeHex], @"#ff6600");
    XCTAssertNil([NSColor colorWithHex:0xFFFFFF + 1 alpha:1.0]);
}


- (void)testKeyword
{
    WFColorCodeType colorCodeType;
    NSColor *color = [NSColor colorWithColorCode:@"MidnightBlue" codeType:&colorCodeType];
    
    XCTAssertEqual(colorCodeType, WFColorCodeCSSKeyword);
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeCSSKeyword], @"MidnightBlue");
    XCTAssertEqualObjects([color colorCodeWithType:WFColorCodeHex], @"#191970");
    XCTAssertNil([NSColor colorWithColorCode:@"foobar" codeType:NULL]);
    
    NSDictionary<NSString *, NSColor *> *keywordColors = [NSColor stylesheetKeywordColors];
    NSString *keyword = @"Orange";
    XCTAssertEqualObjects(keywordColors[keyword], [NSColor colorWithColorCode:keyword codeType:NULL]);
}

@end
