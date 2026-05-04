# ColorCode

__ColorCode__ is a set of color extensions that allows creating NSColor/SwiftUI.Color instances from CSS color code strings, or color code strings from an NSColor instance. It also adds the ability to handle HSL color space.

* __Requirements__: macOS 15 or later, iOS 18 or later


## Usage

WFColorCode supports the following color code styles.

```swift
/// color code type
enum ColorCodeType: Int {
    case hex                // #ffffff
    case hexWithAlpha       // #ffffffff
    case shortHex           // #fff
    case shortHexWithAlpha  // #ffff
    case cssRGB             // rgb(255,255,255)
    case cssRGBa            // rgba(255,255,255,1)
    case cssHSL             // hsl(0,0%,100%)
    case cssHSLa            // hsla(0,0%,100%,1)
    case cssHWB             // hwb(0 0% 100%)
    case cssHWBWithAlpha    // hwb(0 0% 100% / 1)
    case cssKeyword         // White
};
```

When creating colors from color code strings, CSS function color codes also accept the modern space-separated syntax, such as `rgb(255 255 255 / 0.5)` and `hsl(0 0% 100% / 0.5)`. Generated color code strings continue to use the legacy comma-separated syntax, such as `rgba(255,255,255,0.5)` and `hsla(0,0%,100%,0.5)`.

### Example

Import `ColorCode` to use.

```swift
import ColorCode

// create NSColor instance from HSLa color code
var type: ColorCodeType?
if let whiteColor = NSColor(colorCode: "hsla(0,0%,100%,0.5)", type: &type),
   let hex = whiteColor.colorCode(type: .hex) {
    print(hex)  // => "#ffffff"
}

// create NSColor instance from HSLa values
let color = NSColor(deviceHue:0.1, saturation:0.2, lightness:0.3, alpha:1.0)

// create NSColor instance from a CSS3 keyword
let ivoryColor = NSColor(colorCode: "ivory")

// get HSL values from NSColor instance
if let components = color.hslComponents {
    print(components.hue, components.saturation, components.lightness, components.alpha)
}
```


## License

© 2014-2026 1024jp.

The source code is distributed under the terms of the __MIT License__. See the bundled [LICENSE](LICENSE) for details.
