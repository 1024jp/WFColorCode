//
//  SwiftUITests.swift
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

#if canImport(SwiftUI)
import CoreGraphics
import Numerics
import Testing
import ColorCode
import SwiftUI

struct SwiftUITests {
    
    @Test func testColorCreation() {
        
        var type: ColorCodeType?
        
        #expect(Color(colorCode: "#ffffff", type: &type) != nil)
        #expect(type == .hex)
        
        #expect(Color(hex: 0xFF6600) != nil)
        #expect(Color(colorCode: "foobar") == nil)
    }
    
    
    @Test func testHSLColorCreation() throws {
        
        let color = Color(hue: 0.5, saturation: 1, lightness: 1, opacity: 0.4)
        let components = try #require(color.cgColor?.components)
        
        try #require(components.count == 4)
        #expect(components[0] == 1)
        #expect(components[1] == 1)
        #expect(components[2] == 1)
        #expect(components[3].isApproximatelyEqual(to: 0.4, absoluteTolerance: 0.000_001))
    }
}
#endif
