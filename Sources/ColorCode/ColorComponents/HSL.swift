//
//  HSL.swift
//
//  ColorCode
//  https://github.com/1024jp/WFColorCode
//
//  Created by 1024jp on 2021-05-08.
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

struct HSL: ColorComponents {
    
    var hue: Double
    var saturation: Double
    var lightness: Double
    var alpha: Double = 1
    
    var components: [Double] { [self.hue, self.saturation, self.lightness, self.alpha] }
}


extension RGB {
    
    /// The correspondent HSL components.
    var hsl: HSL {
        
        let maxValue = max(self.red, self.green, self.blue)
        let minValue = min(self.red, self.green, self.blue)
        let diff = maxValue - minValue
        
        let saturation = (diff > 0.00001) ? diff / (1 - abs((maxValue + minValue) - 1)) : 0
        let lightness = (maxValue + minValue) / 2
        
        return HSL(hue: self.hue, saturation: saturation, lightness: lightness, alpha: self.alpha)
    }
}


extension HSB {
    
    /// The correspondent HSL components.
    var hsl: HSL {
        
        let lightness = self.brightness * (1 - self.saturation / 2)
        
        let saturation: Double = if lightness > 0, lightness < 1 {
            (self.brightness * self.saturation) / (lightness < 0.5 ? 2 * lightness : 2 - 2 * lightness)
        } else {
            0
        }
        
        return HSL(hue: self.hue, saturation: saturation, lightness: lightness, alpha: self.alpha)
    }
}


extension HSL {
    
    /// The correspondent HSB components.
    var hsb: HSB {
        
        let brightness = self.lightness + self.saturation * min(self.lightness, 1 - self.lightness)
        let saturation = (brightness == 0) ? 0 : 2 * (1 - self.lightness / brightness)
        
        return HSB(hue: self.hue, saturation: saturation, brightness: brightness, alpha: self.alpha)
    }
}
