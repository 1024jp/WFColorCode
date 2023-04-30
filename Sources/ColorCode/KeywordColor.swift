//
//  KeywordColor.swift
//
//  Created by 1024jp on 2017-11-15.

/*
 The MIT License (MIT)
 
 © 2014-2023 1024jp
 
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
            let color = Self.stylesheetColors.first(where: { $0.keyword == keyword })
        else { return nil }
        
        self = color
    }
}



/// The named color defined in the 6-digit RGB hexadecimal value.
public struct KeywordColor: Sendable {
    
    /// The version of stylesheet.
    public enum Version: CaseIterable, Sendable {
        
        case css1
        case css2
        case css3
        case css4
    }
    
    
    /// The 6-digit hexadecimal color value.
    public var value: Int
    
    /// The keyword name in lower case.
    public var keyword: String
    
    /// The version introduced to the stylesheet.
    public var version: Version?
    
    
    /// All color defined in the CSS level 4.
    public static let stylesheetColors: [Self] = [
        // CSS1 (basic colors)
        Self(value: 0x000000, keyword: "black", version: .css1),
        Self(value: 0x000080, keyword: "navy", version: .css1),
        Self(value: 0x0000FF, keyword: "blue", version: .css1),
        Self(value: 0x008000, keyword: "green", version: .css1),
        Self(value: 0x00FF00, keyword: "lime", version: .css1),
        Self(value: 0x00FFFF, keyword: "aqua", version: .css1),
        Self(value: 0x008080, keyword: "teal", version: .css1),
        Self(value: 0x800000, keyword: "maroon", version: .css1),
        Self(value: 0x800080, keyword: "purple", version: .css1),
        Self(value: 0x808000, keyword: "olive", version: .css1),
        Self(value: 0x808080, keyword: "gray", version: .css1),
        Self(value: 0xC0C0C0, keyword: "silver", version: .css1),
        Self(value: 0xFF0000, keyword: "red", version: .css1),
        Self(value: 0xFF00FF, keyword: "fuchsia", version: .css1),
        Self(value: 0xFFFF00, keyword: "yellow", version: .css1),
        Self(value: 0xFFFFFF, keyword: "white", version: .css1),
        
        // CSS2
        Self(value: 0xFFA500, keyword: "orange", version: .css2),
        
        // CSS3
        Self(value: 0x00008B, keyword: "darkblue", version: .css3),
        Self(value: 0x0000CD, keyword: "mediumblue", version: .css3),
        Self(value: 0x006400, keyword: "darkgreen", version: .css3),
        Self(value: 0x008B8B, keyword: "darkcyan", version: .css3),
        Self(value: 0x00BFFF, keyword: "deepskyblue", version: .css3),
        Self(value: 0x00CED1, keyword: "darkturquoise", version: .css3),
        Self(value: 0x00FA9A, keyword: "mediumspringgreen", version: .css3),
        Self(value: 0x00FF7F, keyword: "springgreen", version: .css3),
        Self(value: 0x00FFFF, keyword: "cyan", version: .css3),
        Self(value: 0x191970, keyword: "midnightblue", version: .css3),
        Self(value: 0x1E90FF, keyword: "dodgerblue", version: .css3),
        Self(value: 0x20B2AA, keyword: "lightseagreen", version: .css3),
        Self(value: 0x228B22, keyword: "forestgreen", version: .css3),
        Self(value: 0x2E8B57, keyword: "seagreen", version: .css3),
        Self(value: 0x2F4F4F, keyword: "darkslategray", version: .css3),
        Self(value: 0x32CD32, keyword: "limegreen", version: .css3),
        Self(value: 0x3CB371, keyword: "mediumseagreen", version: .css3),
        Self(value: 0x40E0D0, keyword: "turquoise", version: .css3),
        Self(value: 0x4169E1, keyword: "royalblue", version: .css3),
        Self(value: 0x4682B4, keyword: "steelblue", version: .css3),
        Self(value: 0x483D8B, keyword: "darkslateblue", version: .css3),
        Self(value: 0x48D1CC, keyword: "mediumturquoise", version: .css3),
        Self(value: 0x4B0082, keyword: "indigo", version: .css3),
        Self(value: 0x556B2F, keyword: "darkolivegreen", version: .css3),
        Self(value: 0x5F9EA0, keyword: "cadetblue", version: .css3),
        Self(value: 0x6495ED, keyword: "cornflowerblue", version: .css3),
        Self(value: 0x66CDAA, keyword: "mediumaquamarine", version: .css3),
        Self(value: 0x696969, keyword: "dimgray", version: .css3),
        Self(value: 0x6A5ACD, keyword: "slateblue", version: .css3),
        Self(value: 0x6B8E23, keyword: "olivedrab", version: .css3),
        Self(value: 0x708090, keyword: "slategray", version: .css3),
        Self(value: 0x778899, keyword: "lightslategray", version: .css3),
        Self(value: 0x7B68EE, keyword: "mediumslateblue", version: .css3),
        Self(value: 0x7CFC00, keyword: "lawngreen", version: .css3),
        Self(value: 0x7FFF00, keyword: "chartreuse", version: .css3),
        Self(value: 0x7FFFD4, keyword: "aquamarine", version: .css3),
        Self(value: 0x87CEEB, keyword: "skyblue", version: .css3),
        Self(value: 0x87CEFA, keyword: "lightskyblue", version: .css3),
        Self(value: 0x8A2BE2, keyword: "blueviolet", version: .css3),
        Self(value: 0x8B0000, keyword: "darkred", version: .css3),
        Self(value: 0x8B008B, keyword: "darkmagenta", version: .css3),
        Self(value: 0x8B4513, keyword: "saddlebrown", version: .css3),
        Self(value: 0x8FBC8F, keyword: "darkseagreen", version: .css3),
        Self(value: 0x90EE90, keyword: "lightgreen", version: .css3),
        Self(value: 0x9370DB, keyword: "mediumpurple", version: .css3),
        Self(value: 0x9400D3, keyword: "darkviolet", version: .css3),
        Self(value: 0x98FB98, keyword: "palegreen", version: .css3),
        Self(value: 0x9932CC, keyword: "darkorchid", version: .css3),
        Self(value: 0x9ACD32, keyword: "yellowgreen", version: .css3),
        Self(value: 0xA0522D, keyword: "sienna", version: .css3),
        Self(value: 0xA52A2A, keyword: "brown", version: .css3),
        Self(value: 0xA9A9A9, keyword: "darkgray", version: .css3),
        Self(value: 0xADD8E6, keyword: "lightblue", version: .css3),
        Self(value: 0xADFF2F, keyword: "greenyellow", version: .css3),
        Self(value: 0xAFEEEE, keyword: "paleturquoise", version: .css3),
        Self(value: 0xB0C4DE, keyword: "lightsteelblue", version: .css3),
        Self(value: 0xB0E0E6, keyword: "powderblue", version: .css3),
        Self(value: 0xB22222, keyword: "firebrick", version: .css3),
        Self(value: 0xB8860B, keyword: "darkgoldenrod", version: .css3),
        Self(value: 0xBA55D3, keyword: "mediumorchid", version: .css3),
        Self(value: 0xBC8F8F, keyword: "rosybrown", version: .css3),
        Self(value: 0xBDB76B, keyword: "darkkhaki", version: .css3),
        Self(value: 0xC71585, keyword: "mediumvioletred", version: .css3),
        Self(value: 0xCD5C5C, keyword: "indianred", version: .css3),
        Self(value: 0xCD853F, keyword: "peru", version: .css3),
        Self(value: 0xD2691E, keyword: "chocolate", version: .css3),
        Self(value: 0xD2B48C, keyword: "tan", version: .css3),
        Self(value: 0xD3D3D3, keyword: "lightgray", version: .css3),
        Self(value: 0xD8BFD8, keyword: "thistle", version: .css3),
        Self(value: 0xDA70D6, keyword: "orchid", version: .css3),
        Self(value: 0xDAA520, keyword: "goldenrod", version: .css3),
        Self(value: 0xDB7093, keyword: "palevioletred", version: .css3),
        Self(value: 0xDC143C, keyword: "crimson", version: .css3),
        Self(value: 0xDCDCDC, keyword: "gainsboro", version: .css3),
        Self(value: 0xDDA0DD, keyword: "plum", version: .css3),
        Self(value: 0xDEB887, keyword: "burlywood", version: .css3),
        Self(value: 0xE0FFFF, keyword: "lightcyan", version: .css3),
        Self(value: 0xE6E6FA, keyword: "lavender", version: .css3),
        Self(value: 0xE9967A, keyword: "darksalmon", version: .css3),
        Self(value: 0xEE82EE, keyword: "violet", version: .css3),
        Self(value: 0xEEE8AA, keyword: "palegoldenrod", version: .css3),
        Self(value: 0xF08080, keyword: "lightcoral", version: .css3),
        Self(value: 0xF0E68C, keyword: "khaki", version: .css3),
        Self(value: 0xF0F8FF, keyword: "aliceblue", version: .css3),
        Self(value: 0xF0FFF0, keyword: "honeydew", version: .css3),
        Self(value: 0xF0FFFF, keyword: "azure", version: .css3),
        Self(value: 0xF4A460, keyword: "sandybrown", version: .css3),
        Self(value: 0xF5DEB3, keyword: "wheat", version: .css3),
        Self(value: 0xF5F5DC, keyword: "beige", version: .css3),
        Self(value: 0xF5F5F5, keyword: "whitesmoke", version: .css3),
        Self(value: 0xF5FFFA, keyword: "mintcream", version: .css3),
        Self(value: 0xF8F8FF, keyword: "ghostwhite", version: .css3),
        Self(value: 0xFA8072, keyword: "salmon", version: .css3),
        Self(value: 0xFAEBD7, keyword: "antiquewhite", version: .css3),
        Self(value: 0xFAF0E6, keyword: "linen", version: .css3),
        Self(value: 0xFAFAD2, keyword: "lightgoldenrodyellow", version: .css3),
        Self(value: 0xFDF5E6, keyword: "oldlace", version: .css3),
        Self(value: 0xFF00FF, keyword: "magenta", version: .css3),
        Self(value: 0xFF1493, keyword: "deeppink", version: .css3),
        Self(value: 0xFF4500, keyword: "orangered", version: .css3),
        Self(value: 0xFF6347, keyword: "tomato", version: .css3),
        Self(value: 0xFF69B4, keyword: "hotpink", version: .css3),
        Self(value: 0xFF7F50, keyword: "coral", version: .css3),
        Self(value: 0xFF8C00, keyword: "darkorange", version: .css3),
        Self(value: 0xFFA07A, keyword: "lightsalmon", version: .css3),
        Self(value: 0xFFB6C1, keyword: "lightpink", version: .css3),
        Self(value: 0xFFC0CB, keyword: "pink", version: .css3),
        Self(value: 0xFFD700, keyword: "gold", version: .css3),
        Self(value: 0xFFDAB9, keyword: "peachpuff", version: .css3),
        Self(value: 0xFFDEAD, keyword: "navajowhite", version: .css3),
        Self(value: 0xFFE4B5, keyword: "moccasin", version: .css3),
        Self(value: 0xFFE4C4, keyword: "bisque", version: .css3),
        Self(value: 0xFFE4E1, keyword: "mistyrose", version: .css3),
        Self(value: 0xFFEBCD, keyword: "blanchedalmond", version: .css3),
        Self(value: 0xFFEFD5, keyword: "papayawhip", version: .css3),
        Self(value: 0xFFF0F5, keyword: "lavenderblush", version: .css3),
        Self(value: 0xFFF5EE, keyword: "seashell", version: .css3),
        Self(value: 0xFFF8DC, keyword: "cornsilk", version: .css3),
        Self(value: 0xFFFACD, keyword: "lemonchiffon", version: .css3),
        Self(value: 0xFFFAF0, keyword: "floralwhite", version: .css3),
        Self(value: 0xFFFAFA, keyword: "snow", version: .css3),
        Self(value: 0xFFFFE0, keyword: "lightyellow", version: .css3),
        Self(value: 0xFFFFF0, keyword: "ivory", version: .css3),
        
        // CSS4
        Self(value: 0x663399, keyword: "rebeccapurple", version: .css4),
    ]
}
