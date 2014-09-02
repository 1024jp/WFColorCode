
WFColorCode
=============================

__WFColorCode__ is a NSColor category that allows creating NSColor instance from a CSS color code string, or color code string from a NSColor instance.



Usage
-----------------------------
WFColorCode supports following color code styles.

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

See NSColor+WFColorCode.h file to learn available methods.



Installation
-----------------------------
WFColorCode is available via [CocoaPods](http://cocoapods.org). You can easily insatll it adding the following line to your Podfile:

```ruby
pod "WFColorCode"
```

If you're not using CocoaPods, place NSColor+WFColorCode.h and NSColor+WFColorCode.m somewhare in your project.



License
-----------------------------
© 2014 1024jp.

The source code is distributed under the terms of the __MIT License__. See the bundled "[LICENSE](LICENSE)" for details.
