//
//  HSLTests.swift
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

import Numerics
import Testing
@testable import ColorCode

struct HSLTests {
    
    @Test func testHSBComponents() {
        
        let hsb1 = HSL(hue: 0.5, saturation: 0.5, lightness: 0.25).hsb
        #expect(hsb1.brightness.isApproximatelyEqual(to: 0.375))
        #expect(hsb1.saturation.isApproximatelyEqual(to: 2.0 / 3.0))
        
        let hsb2 = HSL(hue: 0.5, saturation: 0, lightness: 0.5).hsb
        #expect(hsb2.brightness.isApproximatelyEqual(to: 0.5))
        #expect(hsb2.saturation.isApproximatelyEqual(to: 0))
        
        let hsb3 = HSL(hue: 0.5, saturation: 1, lightness: 1).hsb
        #expect(hsb3.brightness.isApproximatelyEqual(to: 1))
        #expect(hsb3.saturation.isApproximatelyEqual(to: 0))
    }
}
