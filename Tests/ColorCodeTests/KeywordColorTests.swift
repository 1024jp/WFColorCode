//
//  KeywordColorTests.swift
//  WFColorCode
//
//  Created by 1024jp on 2022-06-31.

/*
 The MIT License (MIT)
 
 © 2022-2026 1024jp
 
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
import AppKit.NSColor

struct KeywordColorTests {
    
    @Test func testInitialization() throws {
        
        let keyword = "midnightblue"
        let value = 0x191970
        
        let keywordColor = try #require(KeywordColor(keyword: keyword))
        #expect(keywordColor.value == value)
        
        let valueColor = try #require(KeywordColor(value: value))
        #expect(valueColor.keyword == keyword)
    }
    
    
    @Test func testGreyAliases() throws {
        
        let aliases = [
            (keyword: "darkslategrey", value: 0x2F4F4F, hex: "#2f4f4f"),
            (keyword: "dimgrey", value: 0x696969, hex: "#696969"),
            (keyword: "slategrey", value: 0x708090, hex: "#708090"),
            (keyword: "lightslategrey", value: 0x778899, hex: "#778899"),
            (keyword: "grey", value: 0x808080, hex: "#808080"),
            (keyword: "darkgrey", value: 0xA9A9A9, hex: "#a9a9a9"),
            (keyword: "lightgrey", value: 0xD3D3D3, hex: "#d3d3d3"),
        ]
        
        for alias in aliases {
            let keywordColor = try #require(KeywordColor(keyword: alias.keyword))
            #expect(keywordColor.value == alias.value)
            
            let color = try #require(NSColor(colorCode: alias.keyword))
            #expect(color.colorCode(type: .hex) == alias.hex)
        }
    }
}
