//
//  KeywordColor.swift
//
//  Created by 1024jp on 2017-11-15.

/*
 The MIT License (MIT)
 
 © 2014-2022 1024jp
 
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

public extension KeywordColor {
    
    /// Return the KeywordColor with the given color value available in the stylesheet.
    ///
    /// - Parameter value: The 6-digit hexadecimal color value.
    init?(value: Int) {
        
        assert((0x0...0xFFFFFF).contains(value))
        
        guard
            let color = Self.stylesheetColors.first(where: { $0.value == value })
        else { return nil }
        
        self = color
    }
    
    
    /// Return the KeywordColor with the given keyword available in the stylesheet.
    ///
    /// - Parameter keyword: The case-insensitive name of the color.
    init?(keyword: String) {
        
        let keyword = keyword.lowercased()
        
        guard
            let color = Self.stylesheetColors.first(where: { $0.keyword.lowercased() == keyword })
        else { return nil }
        
        self = color
    }
    
}



/// The named color defined in the 6-digit RGB hexadecimal value.
public struct KeywordColor {
    
    /// The version of stylesheet.
    public enum Version: CaseIterable {
        
        case css1
        case css2
        case css3
        case css4
    }
    
    
    /// The 6-digit hexadecimal color value.
    public var value: Int
    
    /// The keyword name in upper camel case.
    public var keyword: String
    
    /// The version introduced to the stylesheet.
    public var version: Version?
    
    
    /// All color defined in the CSS level 4.
    public static let stylesheetColors: [Self] = [
        // CSS1 (basic colors)
        Self(value: 0x000000, keyword: "Black", version: .css1),
        Self(value: 0x000080, keyword: "Navy", version: .css1),
        Self(value: 0x0000FF, keyword: "Blue", version: .css1),
        Self(value: 0x008000, keyword: "Green", version: .css1),
        Self(value: 0x00FF00, keyword: "Lime", version: .css1),
        Self(value: 0x00FFFF, keyword: "Aqua", version: .css1),
        Self(value: 0x008080, keyword: "Teal", version: .css1),
        Self(value: 0x800000, keyword: "Maroon", version: .css1),
        Self(value: 0x800080, keyword: "Purple", version: .css1),
        Self(value: 0x808000, keyword: "Olive", version: .css1),
        Self(value: 0x808080, keyword: "Gray", version: .css1),
        Self(value: 0xC0C0C0, keyword: "Silver", version: .css1),
        Self(value: 0xFF0000, keyword: "Red", version: .css1),
        Self(value: 0xFF00FF, keyword: "Fuchsia", version: .css1),
        Self(value: 0xFFFF00, keyword: "Yellow", version: .css1),
        Self(value: 0xFFFFFF, keyword: "White", version: .css1),
        
        // CSS2
        Self(value: 0xFFA500, keyword: "Orange", version: .css2),
        
        // CSS3
        Self(value: 0x00008B, keyword: "DarkBlue", version: .css3),
        Self(value: 0x0000CD, keyword: "MediumBlue", version: .css3),
        Self(value: 0x006400, keyword: "DarkGreen", version: .css3),
        Self(value: 0x008B8B, keyword: "DarkCyan", version: .css3),
        Self(value: 0x00BFFF, keyword: "DeepSkyBlue", version: .css3),
        Self(value: 0x00CED1, keyword: "DarkTurquoise", version: .css3),
        Self(value: 0x00FA9A, keyword: "MediumSpringGreen", version: .css3),
        Self(value: 0x00FF7F, keyword: "SpringGreen", version: .css3),
        Self(value: 0x00FFFF, keyword: "Cyan", version: .css3),
        Self(value: 0x191970, keyword: "MidnightBlue", version: .css3),
        Self(value: 0x1E90FF, keyword: "DodgerBlue", version: .css3),
        Self(value: 0x20B2AA, keyword: "LightSeaGreen", version: .css3),
        Self(value: 0x228B22, keyword: "ForestGreen", version: .css3),
        Self(value: 0x2E8B57, keyword: "SeaGreen", version: .css3),
        Self(value: 0x2F4F4F, keyword: "DarkSlateGray", version: .css3),
        Self(value: 0x32CD32, keyword: "LimeGreen", version: .css3),
        Self(value: 0x3CB371, keyword: "MediumSeaGreen", version: .css3),
        Self(value: 0x40E0D0, keyword: "Turquoise", version: .css3),
        Self(value: 0x4169E1, keyword: "RoyalBlue", version: .css3),
        Self(value: 0x4682B4, keyword: "SteelBlue", version: .css3),
        Self(value: 0x483D8B, keyword: "DarkSlateBlue", version: .css3),
        Self(value: 0x48D1CC, keyword: "MediumTurquoise", version: .css3),
        Self(value: 0x4B0082, keyword: "Indigo", version: .css3),
        Self(value: 0x556B2F, keyword: "DarkOliveGreen", version: .css3),
        Self(value: 0x5F9EA0, keyword: "CadetBlue", version: .css3),
        Self(value: 0x6495ED, keyword: "CornflowerBlue", version: .css3),
        Self(value: 0x66CDAA, keyword: "MediumAquaMarine", version: .css3),
        Self(value: 0x696969, keyword: "DimGray", version: .css3),
        Self(value: 0x6A5ACD, keyword: "SlateBlue", version: .css3),
        Self(value: 0x6B8E23, keyword: "OliveDrab", version: .css3),
        Self(value: 0x708090, keyword: "SlateGray", version: .css3),
        Self(value: 0x778899, keyword: "LightSlateGray", version: .css3),
        Self(value: 0x7B68EE, keyword: "MediumSlateBlue", version: .css3),
        Self(value: 0x7CFC00, keyword: "LawnGreen", version: .css3),
        Self(value: 0x7FFF00, keyword: "Chartreuse", version: .css3),
        Self(value: 0x7FFFD4, keyword: "Aquamarine", version: .css3),
        Self(value: 0x87CEEB, keyword: "SkyBlue", version: .css3),
        Self(value: 0x87CEFA, keyword: "LightSkyBlue", version: .css3),
        Self(value: 0x8A2BE2, keyword: "BlueViolet", version: .css3),
        Self(value: 0x8B0000, keyword: "DarkRed", version: .css3),
        Self(value: 0x8B008B, keyword: "DarkMagenta", version: .css3),
        Self(value: 0x8B4513, keyword: "SaddleBrown", version: .css3),
        Self(value: 0x8FBC8F, keyword: "DarkSeaGreen", version: .css3),
        Self(value: 0x90EE90, keyword: "LightGreen", version: .css3),
        Self(value: 0x9370DB, keyword: "MediumPurple", version: .css3),
        Self(value: 0x9400D3, keyword: "DarkViolet", version: .css3),
        Self(value: 0x98FB98, keyword: "PaleGreen", version: .css3),
        Self(value: 0x9932CC, keyword: "DarkOrchid", version: .css3),
        Self(value: 0x9ACD32, keyword: "YellowGreen", version: .css3),
        Self(value: 0xA0522D, keyword: "Sienna", version: .css3),
        Self(value: 0xA52A2A, keyword: "Brown", version: .css3),
        Self(value: 0xA9A9A9, keyword: "DarkGray", version: .css3),
        Self(value: 0xADD8E6, keyword: "LightBlue", version: .css3),
        Self(value: 0xADFF2F, keyword: "GreenYellow", version: .css3),
        Self(value: 0xAFEEEE, keyword: "PaleTurquoise", version: .css3),
        Self(value: 0xB0C4DE, keyword: "LightSteelBlue", version: .css3),
        Self(value: 0xB0E0E6, keyword: "PowderBlue", version: .css3),
        Self(value: 0xB22222, keyword: "FireBrick", version: .css3),
        Self(value: 0xB8860B, keyword: "DarkGoldenRod", version: .css3),
        Self(value: 0xBA55D3, keyword: "MediumOrchid", version: .css3),
        Self(value: 0xBC8F8F, keyword: "RosyBrown", version: .css3),
        Self(value: 0xBDB76B, keyword: "DarkKhaki", version: .css3),
        Self(value: 0xC71585, keyword: "MediumVioletRed", version: .css3),
        Self(value: 0xCD5C5C, keyword: "IndianRed", version: .css3),
        Self(value: 0xCD853F, keyword: "Peru", version: .css3),
        Self(value: 0xD2691E, keyword: "Chocolate", version: .css3),
        Self(value: 0xD2B48C, keyword: "Tan", version: .css3),
        Self(value: 0xD3D3D3, keyword: "LightGray", version: .css3),
        Self(value: 0xD8BFD8, keyword: "Thistle", version: .css3),
        Self(value: 0xDA70D6, keyword: "Orchid", version: .css3),
        Self(value: 0xDAA520, keyword: "GoldenRod", version: .css3),
        Self(value: 0xDB7093, keyword: "PaleVioletRed", version: .css3),
        Self(value: 0xDC143C, keyword: "Crimson", version: .css3),
        Self(value: 0xDCDCDC, keyword: "Gainsboro", version: .css3),
        Self(value: 0xDDA0DD, keyword: "Plum", version: .css3),
        Self(value: 0xDEB887, keyword: "BurlyWood", version: .css3),
        Self(value: 0xE0FFFF, keyword: "LightCyan", version: .css3),
        Self(value: 0xE6E6FA, keyword: "Lavender", version: .css3),
        Self(value: 0xE9967A, keyword: "DarkSalmon", version: .css3),
        Self(value: 0xEE82EE, keyword: "Violet", version: .css3),
        Self(value: 0xEEE8AA, keyword: "PaleGoldenRod", version: .css3),
        Self(value: 0xF08080, keyword: "LightCoral", version: .css3),
        Self(value: 0xF0E68C, keyword: "Khaki", version: .css3),
        Self(value: 0xF0F8FF, keyword: "AliceBlue", version: .css3),
        Self(value: 0xF0FFF0, keyword: "HoneyDew", version: .css3),
        Self(value: 0xF0FFFF, keyword: "Azure", version: .css3),
        Self(value: 0xF4A460, keyword: "SandyBrown", version: .css3),
        Self(value: 0xF5DEB3, keyword: "Wheat", version: .css3),
        Self(value: 0xF5F5DC, keyword: "Beige", version: .css3),
        Self(value: 0xF5F5F5, keyword: "WhiteSmoke", version: .css3),
        Self(value: 0xF5FFFA, keyword: "MintCream", version: .css3),
        Self(value: 0xF8F8FF, keyword: "GhostWhite", version: .css3),
        Self(value: 0xFA8072, keyword: "Salmon", version: .css3),
        Self(value: 0xFAEBD7, keyword: "AntiqueWhite", version: .css3),
        Self(value: 0xFAF0E6, keyword: "Linen", version: .css3),
        Self(value: 0xFAFAD2, keyword: "LightGoldenRodYellow", version: .css3),
        Self(value: 0xFDF5E6, keyword: "OldLace", version: .css3),
        Self(value: 0xFF00FF, keyword: "Magenta", version: .css3),
        Self(value: 0xFF1493, keyword: "DeepPink", version: .css3),
        Self(value: 0xFF4500, keyword: "OrangeRed", version: .css3),
        Self(value: 0xFF6347, keyword: "Tomato", version: .css3),
        Self(value: 0xFF69B4, keyword: "HotPink", version: .css3),
        Self(value: 0xFF7F50, keyword: "Coral", version: .css3),
        Self(value: 0xFF8C00, keyword: "DarkOrange", version: .css3),
        Self(value: 0xFFA07A, keyword: "LightSalmon", version: .css3),
        Self(value: 0xFFB6C1, keyword: "LightPink", version: .css3),
        Self(value: 0xFFC0CB, keyword: "Pink", version: .css3),
        Self(value: 0xFFD700, keyword: "Gold", version: .css3),
        Self(value: 0xFFDAB9, keyword: "PeachPuff", version: .css3),
        Self(value: 0xFFDEAD, keyword: "NavajoWhite", version: .css3),
        Self(value: 0xFFE4B5, keyword: "Moccasin", version: .css3),
        Self(value: 0xFFE4C4, keyword: "Bisque", version: .css3),
        Self(value: 0xFFE4E1, keyword: "MistyRose", version: .css3),
        Self(value: 0xFFEBCD, keyword: "BlanchedAlmond", version: .css3),
        Self(value: 0xFFEFD5, keyword: "PapayaWhip", version: .css3),
        Self(value: 0xFFF0F5, keyword: "LavenderBlush", version: .css3),
        Self(value: 0xFFF5EE, keyword: "SeaShell", version: .css3),
        Self(value: 0xFFF8DC, keyword: "Cornsilk", version: .css3),
        Self(value: 0xFFFACD, keyword: "LemonChiffon", version: .css3),
        Self(value: 0xFFFAF0, keyword: "FloralWhite", version: .css3),
        Self(value: 0xFFFAFA, keyword: "Snow", version: .css3),
        Self(value: 0xFFFFE0, keyword: "LightYellow", version: .css3),
        Self(value: 0xFFFFF0, keyword: "Ivory", version: .css3),
        
        Self(value: 0x663399, keyword: "RebeccaPurple", version: .css4),
    ]
    
}
