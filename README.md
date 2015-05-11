
WFColorCode
=============================

[![Build Status](http://img.shields.io/travis/1024jp/WFColorCode.svg?style=flat)](https://travis-ci.org/1024jp/WFColorCode)
[![CocoaPods version](http://img.shields.io/cocoapods/v/WFColorCode.svg?style=flat)](http://cocoadocs.org/docsets/WFColorCode)
[![License](https://img.shields.io/cocoapods/l/WFColorCode.svg?style=flat)](http://cocoadocs.org/docsets/WFColorCode)
[![CocoaPods platform](http://img.shields.io/cocoapods/p/WFColorCode.svg?style=flat)](http://cocoadocs.org/docsets/WFColorCode)

__WFColorCode__ is a NSColor category that allows creating NSColor instance from a CSS color code string, or color code string from a NSColor instance.  It also adds the ability to handle HSL color space.

* __Requirements__: OS X 10.7 or later
* __ARC__: ARC enabled



Usage
-----------------------------
WFColorCode supports the following color code styles.

```objc
/// color code type
typedef NS_ENUM(NSUInteger, WFColorCodeType) {
    WFColorCodeInvalid,   // nil
    WFColorCodeHex,       // #ffffff
    WFColorCodeShortHex,  // #fff
    WFColorCodeCSSRGB,    // rgb(255,255,255)
    WFColorCodeCSSRGBa,   // rgba(255,255,255,1)
    WFColorCodeCSSHSL,    // hsl(0,0%,100%)
    WFColorCodeCSSHSLa    // hsla(0,0%,100%,1)
};
```

```swift
/// color code type
enum WFColorCodeType : UInt {
    case Invalid   // nil
    case Hex       // #ffffff
    case ShortHex  // #fff
    case CSSRGB    // rgb(255,255,255)
    case CSSRGBa   // rgba(255,255,255,1)
    case CSSHSL    // hsl(0,0%,100%)
    case CSSHSLa   // hsla(0,0%,100%,1)
};
```

### Example
Import NSColor+WFColorCode.h to use.

```objc
#import "NSColor+WFColorCode.h"
```

```objc
// create NSColor instance from HSLa color code
WFColorCodeType colorCodeType;
NSColor *whiteColor = [NSColor colorWithColorCode:@"hsla(0,0%,100%,0.5)" codeType:&colorCodeType];
NSString *hex = [whiteColor colorCodeWithType:WFColorCodeHex];  // => #ffffff


// create NSColor instance from HSLa values
NSColor *color = [NSColor colorWithDeviceHue:0.1 saturation:0.2 lightness:0.3 alpha:1.0];

// get HSL values from NSColor instance
CGFloat hue, saturation, lightness, alpha;
[color getHue:&hue saturation:&saturation lightness:&lightness alpha:&alpha];
```

See NSColor+WFColorCode.h file to learn available methods.



Installation
-----------------------------
WFColorCode is available via [CocoaPods](http://cocoapods.org). You can easily install it adding the following line to your Podfile:

```ruby
pod "WFColorCode"
```

If you don't use CocoaPods, place NSColor+WFColorCode.h and NSColor+WFColorCode.m somewhere in your project.



License
-----------------------------
© 2014-2015 1024jp.

The source code is distributed under the terms of the __MIT License__. See the bundled "[LICENSE](LICENSE)" for details.
