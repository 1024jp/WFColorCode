//
//  ColorCodeTypeTests.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2014-09-02.
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

import Numerics
import Testing
@testable import ColorCode

struct ColorCodeTypeTests {
    
    @Test func testHexColorComponents() throws {
        
        try expectComponents(ColorCodeType.hexColorComponents(code: "#336699"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        try expectComponents(ColorCodeType.hexWithAlphaColorComponents(code: "#33669980"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: Double(0x80) / 255)))
        try expectComponents(ColorCodeType.shortHexColorComponents(code: "#369"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        try expectComponents(ColorCodeType.shortHexWithAlphaColorComponents(code: "#369c"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)))
    }
    
    
    @Test func testCSSRGBColorComponents() throws {
        
        try expectComponents(ColorCodeType.cssRGBColorComponents(code: "rgb(51, 102, 153)"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        try expectComponents(ColorCodeType.cssRGBColorComponents(code: "rgb(20% 40% 60%)"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        try expectComponents(ColorCodeType.cssRGBaColorComponents(code: "rgba(51, 102, 153, 0.5)"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)))
        try expectComponents(ColorCodeType.cssRGBaColorComponents(code: "rgb(20% 40% 60% / 50%)"),
                             equals: .rgb(RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)))
    }
    
    
    @Test func testCSSHSLColorComponents() throws {
        
        try expectComponents(ColorCodeType.cssHSLColorComponents(code: "hsl(180, 50%, 25%)"),
                             equals: .hsl(HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 1)))
        try expectComponents(ColorCodeType.cssHSLColorComponents(code: "hsl(180 50 25)"),
                             equals: .hsl(HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 1)))
        try expectComponents(ColorCodeType.cssHSLaColorComponents(code: "hsla(180, 50%, 25%, 0.5)"),
                             equals: .hsl(HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 0.5)))
        try expectComponents(ColorCodeType.cssHSLaColorComponents(code: "hsl(180 50% 25% / 50%)"),
                             equals: .hsl(HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 0.5)))
    }
    
    
    @Test func testCSSHWBColorComponents() throws {
        
        try expectComponents(ColorCodeType.cssHWBColorComponents(code: "hwb(180 20% 30%)"),
                             equals: .hwb(HWB(hue: 0.5, whiteness: 0.2, blackness: 0.3, alpha: 1)))
        try expectComponents(ColorCodeType.cssHWBWithAlphaColorComponents(code: "hwb(180 20% 30% / 50%)"),
                             equals: .hwb(HWB(hue: 0.5, whiteness: 0.2, blackness: 0.3, alpha: 0.5)))
    }
    
    
    @Test func testCSSKeywordColorComponents() throws {
        
        try expectComponents(ColorCodeType.cssKeywordColorComponents(code: "MidnightBlue"),
                             equals: .rgb(RGB(red: Double(0x19) / 255, green: Double(0x19) / 255, blue: Double(0x70) / 255, alpha: 1)))
    }
    
    
    @Test func testInvalidColorComponents() {
        
        #expect(ColorCodeType.hexColorComponents(code: "#33669") == nil)
        #expect(ColorCodeType.hexWithAlphaColorComponents(code: "#3366998") == nil)
        #expect(ColorCodeType.shortHexColorComponents(code: "#36") == nil)
        #expect(ColorCodeType.shortHexWithAlphaColorComponents(code: "#369") == nil)
        #expect(ColorCodeType.cssRGBColorComponents(code: "rgb(256, 0, 0)") == nil)
        #expect(ColorCodeType.cssRGBaColorComponents(code: "rgba(0, 0, 0, 1.1)") == nil)
        #expect(ColorCodeType.cssHSLColorComponents(code: "hsl(361 0% 0%)") == nil)
        #expect(ColorCodeType.cssHSLaColorComponents(code: "hsl(0 0% 0% / 101%)") == nil)
        #expect(ColorCodeType.cssHWBColorComponents(code: "hwb(0 101% 0%)") == nil)
        #expect(ColorCodeType.cssHWBWithAlphaColorComponents(code: "hwb(0 0% 0% / 101%)") == nil)
        #expect(ColorCodeType.cssKeywordColorComponents(code: "foobar") == nil)
    }
    
    
    @Test func testComponentValueParsers() {
        
        #expect(ColorCodeType.percentageComponent("42%") == 42)
        #expect(ColorCodeType.percentageComponent("42") == 42)
        #expect(ColorCodeType.percentageComponent("foo") == nil)
        
        #expect(ColorCodeType.rgbComponent("128") == Double(128) / 255)
        #expect(ColorCodeType.rgbComponent("50%") == 0.5)
        #expect(ColorCodeType.rgbComponent("256") == nil)
        #expect(ColorCodeType.rgbComponent("101%") == nil)
        #expect(ColorCodeType.rgbComponent("foo") == nil)
        
        #expect(ColorCodeType.alphaComponent("0.5") == 0.5)
        #expect(ColorCodeType.alphaComponent("50%") == 0.5)
        #expect(ColorCodeType.alphaComponent("foo") == nil)
        
        #expect(ColorCodeType.optionalAlphaComponent(Optional<String>.none) == 1)
        #expect(ColorCodeType.optionalAlphaComponent(Optional("50%")) == 0.5)
        #expect(ColorCodeType.optionalAlphaComponent(Optional("foo")) == nil)
    }
}


private func expectComponents(_ components: ColorComponents?, equals expectedComponents: ColorComponents) throws {
    
    let components = try #require(components)
    
    switch (components, expectedComponents) {
    case let (.rgb(rgb), .rgb(expectedRGB)):
        #expect(rgb.isApproximatelyEqual(to: expectedRGB))
    case let (.hsl(hsl), .hsl(expectedHSL)):
        #expect(hsl.isApproximatelyEqual(to: expectedHSL))
    case let (.hwb(hwb), .hwb(expectedHWB)):
        #expect(hwb.isApproximatelyEqual(to: expectedHWB))
    default:
        Issue.record("Expected \(expectedComponents), got \(components)")
    }
}

private extension RGB {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        self.red.isApproximatelyEqual(to: other.red, absoluteTolerance: absoluteTolerance) &&
        self.green.isApproximatelyEqual(to: other.green, absoluteTolerance: absoluteTolerance) &&
        self.blue.isApproximatelyEqual(to: other.blue, absoluteTolerance: absoluteTolerance) &&
        self.alpha.isApproximatelyEqual(to: other.alpha, absoluteTolerance: absoluteTolerance)
    }
}


private extension HSL {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        self.hue.isApproximatelyEqual(to: other.hue, absoluteTolerance: absoluteTolerance) &&
        self.saturation.isApproximatelyEqual(to: other.saturation, absoluteTolerance: absoluteTolerance) &&
        self.lightness.isApproximatelyEqual(to: other.lightness, absoluteTolerance: absoluteTolerance) &&
        self.alpha.isApproximatelyEqual(to: other.alpha, absoluteTolerance: absoluteTolerance)
    }
}


private extension HWB {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        self.hue.isApproximatelyEqual(to: other.hue, absoluteTolerance: absoluteTolerance) &&
        self.whiteness.isApproximatelyEqual(to: other.whiteness, absoluteTolerance: absoluteTolerance) &&
        self.blackness.isApproximatelyEqual(to: other.blackness, absoluteTolerance: absoluteTolerance) &&
        self.alpha.isApproximatelyEqual(to: other.alpha, absoluteTolerance: absoluteTolerance)
    }
}
