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
        
        #expect(try #require(RGB(hex: "#336699"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        
        #expect(try #require(RGB(hexWithAlpha: "#33669980"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: Double(0x80) / 255)))
        
        #expect(try #require(RGB(shortHex: "#369"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        
        #expect(try #require(RGB(shortHexWithAlpha: "#369c"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)))
    }
    
    
    @Test func testCSSRGBColorComponents() throws {
        
        #expect(try #require(RGB(css: "rgb(51, 102, 153)"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        #expect(try #require(RGB(css: "rgb(20% 40% 60%)"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)))
        #expect(try #require(RGB(cssWithAlpha: "rgba(51, 102, 153, 0.5)"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)))
        #expect(try #require(RGB(cssWithAlpha: "rgb(20% 40% 60% / 50%)"))
            .isApproximatelyEqual(to: RGB(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)))
    }
    
    
    @Test func testCSSHSLColorComponents() throws {
        
        #expect(try #require(HSL(css: "hsl(180, 50%, 25%)"))
            .isApproximatelyEqual(to: HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 1)))
        #expect(try #require(HSL(css: "hsl(180 50 25)"))
            .isApproximatelyEqual(to: HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 1)))
        #expect(try #require(HSL(cssWithAlpha: "hsla(180, 50%, 25%, 0.5)"))
            .isApproximatelyEqual(to: HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 0.5)))
        #expect(try #require(HSL(cssWithAlpha: "hsl(180 50% 25% / 50%)"))
            .isApproximatelyEqual(to: HSL(hue: 0.5, saturation: 0.5, lightness: 0.25, alpha: 0.5)))
    }
    
    
    @Test func testCSSHWBColorComponents() throws {
        
        #expect(try #require(HWB(css: "hwb(180 20% 30%)"))
            .isApproximatelyEqual(to: HWB(hue: 0.5, whiteness: 0.2, blackness: 0.3, alpha: 1)))
        #expect(try #require(HWB(cssWithAlpha: "hwb(180 20% 30% / 50%)"))
            .isApproximatelyEqual(to: HWB(hue: 0.5, whiteness: 0.2, blackness: 0.3, alpha: 0.5)))
    }
    
    
    @Test func testCSSKeywordColorComponents() throws {
        
        #expect(try #require(RGB(cssKeyword: "MidnightBlue"))
            .isApproximatelyEqual(to: RGB(red: Double(0x19) / 255, green: Double(0x19) / 255, blue: Double(0x70) / 255, alpha: 1)))
    }
    
    
    @Test func testInvalidColorComponents() {
        
        #expect(RGB(hex: "#33669") == nil)
        #expect(RGB(hexWithAlpha: "#3366998") == nil)
        #expect(RGB(shortHex: "#36") == nil)
        #expect(RGB(shortHexWithAlpha: "#369") == nil)
        #expect(RGB(css: "rgb(256, 0, 0)") == nil)
        #expect(RGB(cssWithAlpha: "rgba(0, 0, 0, 1.1)") == nil)
        #expect(HSL(css: "hsl(361 0% 0%)") == nil)
        #expect(HSL(cssWithAlpha: "hsl(0 0% 0% / 101%)") == nil)
        #expect(HWB(css: "hwb(0 101% 0%)") == nil)
        #expect(HWB(css: "hwb(0 0% 0% / 101%)") == nil)
        #expect(RGB(cssKeyword: "foobar") == nil)
    }
}


// MARK: Private Helpers

private extension RGB {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        zip(self.components, other.components)
            .allSatisfy { $0.0.isApproximatelyEqual(to: $0.1, absoluteTolerance: absoluteTolerance) }
    }
}


private extension HSL {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        zip(self.components, other.components)
            .allSatisfy { $0.0.isApproximatelyEqual(to: $0.1, absoluteTolerance: absoluteTolerance) }
    }
}


private extension HWB {
    
    func isApproximatelyEqual(to other: Self, absoluteTolerance: Double = 0.000_001) -> Bool {
        
        zip(self.components, other.components)
            .allSatisfy { $0.0.isApproximatelyEqual(to: $0.1, absoluteTolerance: absoluteTolerance) }
    }
}
