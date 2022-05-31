CHANGELOG
===========

2.8.0
-----------

## new

- Add KeywordColor struct.

### mod

- Change the stylesheet keywords from the upper camel case to the lower case.
- Deprecate NSColor.stylesheetKeywordColors (Use KeywordColor.stylesheetColors instead).


2.7.1
-----------

### fix

- Fix an issue in SwiftUI.Color that the alpha value was ignored when specified the color in hex.


2.7.0
-----------

### new

- Support SwiftUI Color creation.


2.6.1
-----------

### mod

- Bump up supported macOS version to 10.10.
- Improve Package.swift declaration.


2.6.0
-----------

### mod

- Make alpha value in NSColor init omittable.
- Make sure the detected inout `type` paramater is set to `nil` when NSColor creation with a color code failed.


### fix

- Fix an issue where NSColor initialization with a color code could crash when just `.` is passed as a float number.


2.5.0
-----------

### fix

- fix Package.swift


2.4.0
-----------

### mod

- Update code to Swift 5.0.


2.3.0
-----------

### mod

- Update code to Swift 4.2.


2.2.1
-----------

### fix

- fix ColorCodeType enum number.

2.2.0
-----------

### mod

- remove .invalid case from ColorCodeType.


2.1.3
-----------
### mod
- Update Xcode to 9.3.


2.1.2
-----------
### mod
- Tweak code

### fix
- Fix swift package manager


2.1.0
-----------
### mod
- Update Xcode to 9.1.


2.0.4
-----------
### mod
- Update Xcode to 8.2.


2.0.1
-----------
### mod
- Update Swift to 3.0.1.


2.0.0
-----------
### new
- Migrate to Swift
- Become a framework
- Change target OS to OS X 10.9 or higher.


1.3.0
-----------
### new
- Support Objective-C generics of Xcode 7


1.2.0
-----------
### new
- Add `WFColorCodeCSSKeyword` color code type.
- Add `colorWithHex:alpha:` and `stylesheetKeywordColors` class methods.

### mod
- Return `instancetype` instead of `NSColor`.


1.1.4
-----------
### mod
- Add more documentation.


1.1.3
-----------
### fix
- A trivial fix for nullability annotations.


1.1.2
-----------
### mod
- Add nullability to methods.


1.1.1
-----------
### mod
- Use `NSCalibratedRGBColorSpace` instead of `NSDeviceRGBColorSpace` for NSColor creation


1.1
-----------
### new
- New methods `hslSaturationComponent` and `lightnessComponent`

### mod
- Add detailed doc comments
