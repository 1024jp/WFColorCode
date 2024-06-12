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

import Testing
import ColorCode
import Numerics
import AppKit.NSColor

struct ColorCodeTests {
    
    @Test func testCaseIteration() {
        
        #expect(ColorCodeType.allCases == [.hex, .hexWithAlpha, .shortHex, .cssRGB, .cssRGBa, .cssHSL, .cssHSLa, .cssKeyword])
    }
    
    
    @Test func testColorCreation() {
        
        let whiteColor = NSColor.white.usingColorSpace(.genericRGB)!
        var type: ColorCodeType?
        
        #expect(NSColor(colorCode: "#ffffff", type: &type) == whiteColor)
        #expect(type == .hex)
        
        #expect(NSColor(colorCode: "#ffffffff", type: &type) == whiteColor)
        #expect(type == .hexWithAlpha)
        
        #expect(NSColor(colorCode: "#fff", type: &type) == whiteColor)
        #expect(type == .shortHex)
        
        #expect(NSColor(colorCode: "rgb(255,255,255)", type: &type) == whiteColor)
        #expect(type == .cssRGB)
        
        #expect(NSColor(colorCode: "rgba(255,255,255,1)", type: &type) == whiteColor)
        #expect(type == .cssRGBa)
        
        #expect(NSColor(colorCode: "hsl(0,0%,100%)", type: &type) == whiteColor)
        #expect(type == .cssHSL)
        
        #expect(NSColor(colorCode: "hsla(0,0%,100%,1)", type: &type) == whiteColor)
        #expect(type == .cssHSLa)
        
        #expect(NSColor(colorCode: "white", type: &type) == whiteColor)
        #expect(type == .cssKeyword)
        
        #expect(NSColor(colorCode: "", type: &type) == nil)
        #expect(type == nil)
        
        #expect(NSColor(colorCode: "foobar", type: &type) == nil)
        #expect(type == nil)
        
        #expect(NSColor(colorCode: "rgba(255,255,255,.)", type: &type) == nil)
        #expect(type == nil)
    }
    
    
    @Test func testInfiniteComponents() throws {
        
        let code = "hsl(0,0%,0%)"
        let black = try #require(NSColor(colorCode: code))
        
        #expect(black.redComponent.isFinite)
        #expect(black.greenComponent.isNaN)
        #expect(black.blueComponent.isNaN)
        #expect(black.colorCode(type: .cssHSL) == code)
    }
    
    
    @Test func testWhite() throws {
        
        let color = NSColor.white.usingColorSpace(.genericRGB)!
        
        #expect(color.colorCode(type: .hex) == "#ffffff")
        #expect(color.colorCode(type: .hexWithAlpha) == "#ffffffff")
        #expect(color.colorCode(type: .shortHex) == "#fff")
        #expect(color.colorCode(type: .cssRGB) == "rgb(255,255,255)")
        #expect(color.colorCode(type: .cssRGBa) == "rgba(255,255,255,1)")
        #expect(color.colorCode(type: .cssHSL) == "hsl(0,0%,100%)")
        #expect(color.colorCode(type: .cssHSLa) == "hsla(0,0%,100%,1)")
        #expect(color.colorCode(type: .cssKeyword) == "white")
        
        let codeColor = try #require(NSColor(colorCode: "#ffffff"))
        #expect(codeColor.colorCode(type: .cssKeyword) == "white")
    }
    
    
    @Test func testBlack() throws {
        
        let color = NSColor.black.usingColorSpace(.genericRGB)!
        
        #expect(color.colorCode(type: .hex) == "#000000")
        #expect(color.colorCode(type: .hexWithAlpha) == "#000000ff")
        #expect(color.colorCode(type: .shortHex) == "#000")
        #expect(color.colorCode(type: .cssRGB) == "rgb(0,0,0)")
        #expect(color.colorCode(type: .cssRGBa) == "rgba(0,0,0,1)")
        #expect(color.colorCode(type: .cssHSL) == "hsl(0,0%,0%)")
        #expect(color.colorCode(type: .cssHSLa) == "hsla(0,0%,0%,1)")
        #expect(color.colorCode(type: .cssKeyword) == "black")
        
        let codeColor = try #require(NSColor(colorCode: "#000000"))
        #expect(codeColor.colorCode(type: .cssKeyword) == "black")
    }
    
    
    @Test func testHSLaColorCode() throws {
        
        let colorCode = "hsla(203,10%,20%,0.3)"
        var type: ColorCodeType?
        let color = try #require(NSColor(colorCode: colorCode, type: &type))
        
        #expect(type == .cssHSLa)
        #expect(color.colorCode(type: .cssHSLa) == colorCode)
    }
    
    
    @Test func testHexColorCode() throws {
        
        var type: ColorCodeType?
        let color = try #require(NSColor(colorCode: "#0066aa", type: &type))
        
        #expect(type == .hex)
        #expect(color.colorCode(type: .hex) == "#0066aa")
        #expect(color.colorCode(type: .hexWithAlpha) == "#0066aaff")
        #expect(color.colorCode(type: .shortHex) == "#06a")
    }
    
    
    @Test func testHSL() {
        
        let color = NSColor(deviceHue: 0.1, saturation: 0.2, lightness: 0.3, alpha: 0.4)
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var lightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(hue: &hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
        
        #expect(hue.isApproximatelyEqual(to: 0.1))
        #expect(saturation.isApproximatelyEqual(to: 0.2))
        #expect(lightness.isApproximatelyEqual(to: 0.3))
        #expect(alpha.isApproximatelyEqual(to: 0.4))
    }
    
    
    @Test(arguments: [NSColorSpace.genericRGB, NSColorSpace.deviceRGB])
    func testColorSpace(_ colorSpace: NSColorSpace) {
        
        #expect(NSColor.white.usingColorSpace(colorSpace)!.hslSaturationComponent == 0)
    }
    
    
    @Test func testHex() throws {
        
        let color = try #require(NSColor(hex: 0xFF6600))
        
        #expect(color.colorCode(type: .hex) == "#ff6600")
        #expect(NSColor(hex: 0xFFFFFF + 1) == nil)
    }
    
    
    @Test func testHexWithAlpha() throws {
        
        let colorCode = "#ff660080"
        var type: ColorCodeType?
        let color = try #require(NSColor(colorCode: colorCode, type: &type))
        
        #expect(type == .hexWithAlpha)
        #expect(color.alphaComponent.isApproximatelyEqual(to: 0.5, absoluteTolerance: 0.01))
        #expect(color.colorCode(type: .hexWithAlpha) == colorCode)
    }
    
    
    @Test func testKeyword() throws {
        
        var type: ColorCodeType?
        let blue = try #require(NSColor(colorCode: "MidnightBlue", type: &type))
        
        #expect(type == .cssKeyword)
        #expect(blue.colorCode(type: .cssKeyword) == "midnightblue")
        #expect(blue.colorCode(type: .hex) == "#191970")
        #expect(NSColor(colorCode: "foobar") == nil)
        
        let white = try #require(NSColor(colorCode: "white"))
        #expect(white.colorCode(type: .hex) == "#ffffff")
        
        let black = try #require(NSColor(colorCode: "black"))
        #expect(black.colorCode(type: .hex) == "#000000")
    }
}
