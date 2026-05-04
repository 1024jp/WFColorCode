//
//  HWB.swift
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

struct HWB {
    
    var hue: Double
    var whiteness: Double
    var blackness: Double
    var alpha: Double = 1
    
    var components: [Double] { [self.hue, self.whiteness, self.blackness, self.alpha] }
    
    
    /// The correspondent RGB components.
    var rgb: RGB {
        
        if self.whiteness + self.blackness >= 1 {
            let gray = self.whiteness / (self.whiteness + self.blackness)
            return RGB(red: gray, green: gray, blue: gray, alpha: self.alpha)
        }
        
        func channel(_ value: Double) -> Double {
            
            let k = (value + self.hue * 12).truncatingRemainder(dividingBy: 12)
            let a: Double = 0.5
            
            return 0.5 - a * max(-1, min(k - 3, 9 - k, 1))
        }
        
        let factor = 1 - self.whiteness - self.blackness
        
        return RGB(red: channel(0) * factor + self.whiteness,
                   green: channel(8) * factor + self.whiteness,
                   blue: channel(4) * factor + self.whiteness,
                   alpha: self.alpha)
    }
}


extension RGB {
    
    /// The correspondent HWB components.
    var hwb: HWB {
        
        let maxValue = max(self.red, self.green, self.blue)
        let minValue = min(self.red, self.green, self.blue)
        
        return HWB(hue: self.hue, whiteness: minValue, blackness: 1 - maxValue, alpha: self.alpha)
    }
}
