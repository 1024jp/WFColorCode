//
//  ColorCodeTests.swift
//  WFColorCode
//
//  Created by 1024jp on 2014-09-02.

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

import XCTest
import ColorCode

final class ColorCodeTests: XCTestCase {
    
    func testCaseIteration() {
        
        XCTAssertEqual(ColorCodeType.allCases, 
                       [.hex, .hexWithAlpha, .shortHex, .cssRGB, .cssRGBa, .cssHSL, .cssHSLa, .cssKeyword])
    }
    
    
    func testColorCreation() {
        
        let whiteColor = NSColor.white.usingColorSpace(.genericRGB)!
        var type: ColorCodeType?
        
        XCTAssertEqual(NSColor(colorCode: "#ffffff", type: &type), whiteColor)
        XCTAssertEqual(type, .hex)
        
        XCTAssertEqual(NSColor(colorCode: "#ffffffff", type: &type), whiteColor)
        XCTAssertEqual(type, .hexWithAlpha)
        
        XCTAssertEqual(NSColor(colorCode: "#fff", type: &type), whiteColor)
        XCTAssertEqual(type, .shortHex)
        
        XCTAssertEqual(NSColor(colorCode: "rgb(255,255,255)", type: &type), whiteColor)
        XCTAssertEqual(type, .cssRGB)
        
        XCTAssertEqual(NSColor(colorCode: "rgba(255,255,255,1)", type: &type), whiteColor)
        XCTAssertEqual(type, .cssRGBa)
        
        XCTAssertEqual(NSColor(colorCode: "hsl(0,0%,100%)", type: &type), whiteColor)
        XCTAssertEqual(type, .cssHSL)
        
        XCTAssertEqual(NSColor(colorCode: "hsla(0,0%,100%,1)", type: &type), whiteColor)
        XCTAssertEqual(type, .cssHSLa)
        
        XCTAssertEqual(NSColor(colorCode: "white", type: &type), whiteColor)
        XCTAssertEqual(type, .cssKeyword)
        
        XCTAssertNil(NSColor(colorCode: "", type: &type))
        XCTAssertNil(type)
        
        XCTAssertNil(NSColor(colorCode: "foobar", type: &type))
        XCTAssertNil(type)
        
        XCTAssertNil(NSColor(colorCode: "rgba(255,255,255,.)", type: &type))
        XCTAssertNil(type)
    }
    
    
    func testInfiniteComponents() {
        
        let code = "hsl(0,0%,0%)"
        let black = NSColor(colorCode: code)!
        
        XCTAssert(black.redComponent.isFinite)
        XCTAssert(black.greenComponent.isNaN)
        XCTAssert(black.blueComponent.isNaN)
        XCTAssertEqual(black.colorCode(type: .cssHSL), code)
    }
    
    
    func testWhite() throws {
        
        let color = NSColor.white.usingColorSpace(.genericRGB)!
        
        XCTAssertEqual(color.colorCode(type: .hex), "#ffffff")
        XCTAssertEqual(color.colorCode(type: .hexWithAlpha), "#ffffffff")
        XCTAssertEqual(color.colorCode(type: .shortHex), "#fff")
        XCTAssertEqual(color.colorCode(type: .cssRGB), "rgb(255,255,255)")
        XCTAssertEqual(color.colorCode(type: .cssRGBa), "rgba(255,255,255,1)")
        XCTAssertEqual(color.colorCode(type: .cssHSL), "hsl(0,0%,100%)")
        XCTAssertEqual(color.colorCode(type: .cssHSLa), "hsla(0,0%,100%,1)")
        XCTAssertEqual(color.colorCode(type: .cssKeyword), "white")
        
        let codeColor = try XCTUnwrap(NSColor(colorCode: "#ffffff"))
        XCTAssertEqual(codeColor.colorCode(type: .cssKeyword), "white")
    }
    
    
    func testBlack() throws {
        
        let color = NSColor.black.usingColorSpace(.genericRGB)!
        
        XCTAssertEqual(color.colorCode(type: .hex), "#000000")
        XCTAssertEqual(color.colorCode(type: .hexWithAlpha), "#000000ff")
        XCTAssertEqual(color.colorCode(type: .shortHex), "#000")
        XCTAssertEqual(color.colorCode(type: .cssRGB), "rgb(0,0,0)")
        XCTAssertEqual(color.colorCode(type: .cssRGBa), "rgba(0,0,0,1)")
        XCTAssertEqual(color.colorCode(type: .cssHSL), "hsl(0,0%,0%)")
        XCTAssertEqual(color.colorCode(type: .cssHSLa), "hsla(0,0%,0%,1)")
        XCTAssertEqual(color.colorCode(type: .cssKeyword), "black")
        
        let codeColor = try XCTUnwrap(NSColor(colorCode: "#000000"))
        XCTAssertEqual(codeColor.colorCode(type: .cssKeyword), "black")
    }
    
    
    func testHSLaColorCode() throws {
        
        let colorCode = "hsla(203,10%,20%,0.3)"
        var type: ColorCodeType?
        let color = try XCTUnwrap(NSColor(colorCode: colorCode, type: &type))
        
        XCTAssertEqual(type, .cssHSLa)
        XCTAssertEqual(color.colorCode(type: .cssHSLa), colorCode)
    }
    
    
    func testHexColorCode() throws {
        
        var type: ColorCodeType?
        let color = try XCTUnwrap(NSColor(colorCode: "#0066aa", type: &type))
        
        XCTAssertEqual(type, .hex)
        XCTAssertEqual(color.colorCode(type: .hex), "#0066aa")
        XCTAssertEqual(color.colorCode(type: .hexWithAlpha), "#0066aaff")
        XCTAssertEqual(color.colorCode(type: .shortHex), "#06a")
    }
    
    
    func testHSL() {
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var lightness: CGFloat = 0
        var alpha: CGFloat = 0
        let color = NSColor(deviceHue: 0.1, saturation: 0.2, lightness: 0.3, alpha: 0.4)
        
        color.getHue(hue: &hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
        
        XCTAssertEqual(hue, 0.1, accuracy: 3)
        XCTAssertEqual(saturation, 0.2, accuracy: 3)
        XCTAssertEqual(lightness, 0.3, accuracy: 3)
        XCTAssertEqual(alpha, 0.4, accuracy: 3)
    }
    
    
    func testColorSpace() {
        
        XCTAssertEqual(NSColor.white.usingColorSpace(.genericRGB)!.hslSaturationComponent, 0)
        XCTAssertEqual(NSColor.white.usingColorSpace(.deviceRGB)!.hslSaturationComponent, 0)
    }
    
    
    func testHex() throws {
        
        let color = try XCTUnwrap(NSColor(hex: 0xFF6600))
        
        XCTAssertEqual(color.colorCode(type: .hex), "#ff6600")
        XCTAssertNil(NSColor(hex: 0xFFFFFF + 1))
    }
    
    
    func testHexWithAlpha() throws {
        
        let colorCode = "#ff660080"
        var type: ColorCodeType?
        let color = try XCTUnwrap(NSColor(colorCode: colorCode, type: &type))
        
        XCTAssertEqual(type, .hexWithAlpha)
        XCTAssertEqual(color.alphaComponent, 0.5, accuracy: 0.01)
        XCTAssertEqual(color.colorCode(type: .hexWithAlpha), colorCode)
    }
    
    
    func testKeyword() throws {
        
        var type: ColorCodeType?
        let blue = try XCTUnwrap(NSColor(colorCode: "MidnightBlue", type: &type))
        
        XCTAssertEqual(type, .cssKeyword)
        XCTAssertEqual(blue.colorCode(type: .cssKeyword), "midnightblue")
        XCTAssertEqual(blue.colorCode(type: .hex), "#191970")
        XCTAssertNil(NSColor(colorCode: "foobar"))
        
        let white = try XCTUnwrap(NSColor(colorCode: "white"))
        XCTAssertEqual(white.colorCode(type: .hex), "#ffffff")
        
        let black = try XCTUnwrap(NSColor(colorCode: "black"))
        XCTAssertEqual(black.colorCode(type: .hex), "#000000")
    }
}
