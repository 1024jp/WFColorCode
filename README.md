
WFColorCode
=============================

[![Test Status](https://github.com/1024jp/WFColorCode/workflows/Test/badge.svg)](https://github.com/1024jp/WFColorCode/actions)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-✔-4BC51D.svg?style=flat)](https://swift.org/package-manager/)

__WFColorCode__ is a NSColor extension that allows creating NSColor instance from a CSS color code string, or color code string from a NSColor instance.  It also adds the ability to handle HSL color space.

* __Requirements__: OS X 10.9 or later
* __ARC__: ARC enabled



Usage
-----------------------------
WFColorCode supports the following color code styles.

```swift
/// color code type
enum ColorCodeType: Int {
    case hex        // #ffffff
    case shortHex   // #fff
    case cssRGB     // rgb(255,255,255)
    case cssRGBa    // rgba(255,255,255,1)
    case cssHSL     // hsl(0,0%,100%)
    case cssHSLa    // hsla(0,0%,100%,1)
    case cssKeyword // White
};
```

### Example
Import `ColorCode` to use.

```swift
import ColorCode

// create NSColor instance from HSLa color code
var type: ColorCodeType?
let whiteColor = NSColor(colorCode: "hsla(0,0%,100%,0.5)", type: &type)
let hex: String = whiteColor.colorCode(type: .hex)  // => "#ffffff"

// create NSColor instance from HSLa values
let color = NSColor(deviceHue:0.1, saturation:0.2, lightness:0.3, alpha:1.0)

// create NSColor instance from a CSS3 keyword
let ivoryColor = NSColor(colorCode: "ivory")

// get HSL values from NSColor instance
var hue: CGFloat = 0
var saturation: CGFloat = 0
var lightness: CGFloat = 0
var alpha: CGFloat = 0
color.getHue(hue: &hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)
```



Installation
-----------------------------

### Swift Package Manager
WFColorCode is SwiftPM compatible.

### Source files
If you use neither CocoaPods nor SwiftPM, place NSColor+ColorCode.swift and NSColor+HSL.swift in Classes/ directory somewhere in your project.



License
-----------------------------
© 2014-2019 1024jp.

The source code is distributed under the terms of the __MIT License__. See the bundled "[LICENSE](LICENSE)" for details.
