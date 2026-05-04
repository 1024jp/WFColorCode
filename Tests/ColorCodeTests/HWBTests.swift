//
//  HWBTests.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2026-05-04.
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

import Testing
@testable import ColorCode

struct HWBTests {
    
    @Test func testRGBComponents() {
        
        #expect(HWB(hue: 0, whiteness: 0, blackness: 0).rgb ~== RGB(red: 1, green: 0, blue: 0))
        #expect(HWB(hue: 1.0 / 3.0, whiteness: 0, blackness: 0).rgb ~== RGB(red: 0, green: 1, blue: 0))
        #expect(HWB(hue: 2.0 / 3.0, whiteness: 0, blackness: 0).rgb ~== RGB(red: 0, green: 0, blue: 1))
        #expect(HWB(hue: 150.0 / 360.0, whiteness: 0.2, blackness: 0.1).rgb ~== RGB(red: 0.2, green: 0.9, blue: 0.55))
    }
    
    
    @Test func testRGBComponentsWithAchromaticHWB() {
        
        #expect(HWB(hue: 0.5, whiteness: 0.4, blackness: 0.8).rgb ~== RGB(red: 1.0 / 3.0, green: 1.0 / 3.0, blue: 1.0 / 3.0))
        #expect(HWB(hue: 0.5, whiteness: 0.4, blackness: 0.8, alpha: 0.25).rgb ~== RGB(red: 1.0 / 3.0, green: 1.0 / 3.0, blue: 1.0 / 3.0, alpha: 0.25))
    }
    
    
    @Test func testHWBComponents() {
        
        #expect(RGB(red: 1, green: 0, blue: 0).hwb ~== HWB(hue: 0, whiteness: 0, blackness: 0))
        #expect(RGB(red: 0, green: 1, blue: 0).hwb ~== HWB(hue: 1.0 / 3.0, whiteness: 0, blackness: 0))
        #expect(RGB(red: 0, green: 0, blue: 1).hwb ~== HWB(hue: 2.0 / 3.0, whiteness: 0, blackness: 0))
        #expect(RGB(red: 1, green: 0, blue: 0.5).hwb ~== HWB(hue: 11.0 / 12.0, whiteness: 0, blackness: 0))
    }
    
    
    @Test func testHWBComponentsWithAchromaticRGB() {
        
        #expect(RGB(red: 1.0 / 3.0, green: 1.0 / 3.0, blue: 1.0 / 3.0).hwb ~== HWB(hue: 0, whiteness: 1.0 / 3.0, blackness: 2.0 / 3.0))
    }
}
