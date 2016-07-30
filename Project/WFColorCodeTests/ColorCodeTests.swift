//
//  ColorCodeTests.swift
//  WFColorCode
//
//  Created by 1024jp on 2014-09-02.

/*
 The MIT License (MIT)
 
 Copyright (c) 2014-2016 1024jp
 
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

import Cocoa
import XCTest

class ColorCodeTests: XCTestCase {

    func testColorCreation() {
        
        let whiteColor = NSColor.white().usingColorSpaceName(NSCalibratedRGBColorSpace)
        var type: WFColorCodeType = .invalid
        
        XCTAssertEqual(NSColor(colorCode: "#ffffff", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.hex)
        
        XCTAssertEqual(NSColor(colorCode: "#fff", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.shortHex)
        
        XCTAssertEqual(NSColor(colorCode: "rgb(255,255,255)", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.CSSRGB)
        
        XCTAssertEqual(NSColor(colorCode: "rgba(255,255,255,1)", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.cssrgBa)
        
        XCTAssertEqual(NSColor(colorCode: "hsl(0,0%,100%)", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.CSSHSL)
        
        XCTAssertEqual(NSColor(colorCode: "hsla(0,0%,100%,1)", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.csshsLa)
        
        XCTAssertEqual(NSColor(colorCode: "white", codeType: &type), whiteColor)
        XCTAssertEqual(type, WFColorCodeType.cssKeyword)
        
        XCTAssertNil(NSColor(colorCode: "", codeType: &type))
        XCTAssertEqual(type, WFColorCodeType.invalid)
        
        XCTAssertNil(NSColor(colorCode: "foobar", codeType: &type))
        XCTAssertEqual(type, WFColorCodeType.invalid)
    }
    
    
    func testWhite() {
        
        let color = NSColor.white().usingColorSpaceName(NSCalibratedRGBColorSpace)
        
        XCTAssertEqual(color?.colorCode(with: .hex), "#ffffff")
        XCTAssertEqual(color?.colorCode(with: .shortHex), "#fff")
        XCTAssertEqual(color?.colorCode(with: .CSSRGB), "rgb(255,255,255)")
        XCTAssertEqual(color?.colorCode(with: .cssrgBa), "rgba(255,255,255,1)")
        XCTAssertEqual(color?.colorCode(with: .CSSHSL), "hsl(0,0%,100%)")
        XCTAssertEqual(color?.colorCode(with: .csshsLa), "hsla(0,0%,100%,1)")
        XCTAssertEqual(color?.colorCode(with: .cssKeyword), "White")
        XCTAssertNil(color?.colorCode(with: .invalid))
    }
    
    
    func testHSLaColorCode() {
        
        let colorCode = "hsla(203,10%,20%,0.3)"
        var type: WFColorCodeType = .invalid
        let color = NSColor(colorCode: colorCode, codeType: &type)
        
        XCTAssertEqual(type, WFColorCodeType.csshsLa)
        XCTAssertEqual(color?.colorCode(with: type), colorCode)
    }
    
    
    func testHexColorCode() {
        
        var type: WFColorCodeType = .invalid
        let color = NSColor(colorCode: "#0066aa", codeType: &type)
        
        XCTAssertEqual(type, WFColorCodeType.hex)
        XCTAssertEqual(color?.colorCode(with: .hex), "#0066aa")
        XCTAssertEqual(color?.colorCode(with: .shortHex), "#06a")
    }
    
    
    func testHSL() {
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var lightness: CGFloat = 0
        var alpha: CGFloat = 0
        let color = NSColor(deviceHue: 0.1, saturation: 0.2, lightness: 0.3, alpha: 0.4)
        
        color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
        
        XCTAssertEqualWithAccuracy(hue, 0.1, accuracy: 3)
        XCTAssertEqualWithAccuracy(saturation, 0.2, accuracy: 3)
        XCTAssertEqualWithAccuracy(lightness, 0.3, accuracy: 3)
        XCTAssertEqualWithAccuracy(alpha, 0.4, accuracy: 3)
    }
    
    
    func testHex() {
        
        let color = NSColor(hex: 0xFF6600, alpha: 1.0)
        
        XCTAssertEqual(color?.colorCode(with: .hex), "#ff6600")
        XCTAssertNil(NSColor(hex: 0xFFFFFF + 1, alpha: 1.0))
    }
    
    
    func testKeyword() {
        
        var type: WFColorCodeType = .invalid
        let color = NSColor(colorCode: "MidnightBlue", codeType: &type)
        
        XCTAssertEqual(type, WFColorCodeType.cssKeyword)
        XCTAssertEqual(color?.colorCode(with: .cssKeyword), "MidnightBlue")
        XCTAssertEqual(color?.colorCode(with: .hex), "#191970")
        XCTAssertNil(NSColor(colorCode: "foobar", codeType: nil))
        
        let keywordColors = NSColor.stylesheetKeywordColors()
        let keyword = "Orange"
        XCTAssertEqual(keywordColors[keyword], NSColor(colorCode: keyword, codeType: nil))
    }
    
}
