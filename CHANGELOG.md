# Change Log

4.0.0 (unreleased)
--------------------------

### Added

- Add `hexTypes` and `cssTypes` static properties to `ColorCodeType`.
- Add `hslComponents` to `NSColor` for reading HSL values without pointer arguments.


### Changed

- Update code for Swift 6.3.
- Raise the minimum supported macOS version to 15.
- Return `nil` for out-of-range hexadecimal color values instead of asserting.
- Return `nil` for CSS color codes with out-of-range numeric components.


### Deprecated

- Deprecate `getHue(hue:saturation:lightness:alpha:)` in favor of `hslComponents`.


### Fixed

- Create black colors from HSL color codes without producing NaN components.
- Align `ColorCodeType` raw values with the case order.
- Return `nil` instead of lossy short hexadecimal color codes.
- Recognize CSS color keyword aliases that use the "grey" spelling.


3.0.1 (2024-10-20)
--------------------------

### Changed

- Migrate away from deprecated APIs.


3.0.0 (2024-06-13)
--------------------------

### Changed

- Update code for Swift 6.0.
- Migrate unit tests to Swift Testing.


2.10.0 (2024-01-25)
--------------------------

### Added

- Add the `.hexWithAlpha` color code type.


### Changed

- Update code for Swift 5.9.


2.9.1 (2024-01-09)
--------------------------

### Fixed

- Fix a crash that could occur when calling `colorCode(type:)` in certain circumstances.


2.9.0 (2022-09-23)
--------------------------

### Changed

- Raise the minimum supported macOS version to 11.


2.8.0 (2022-05-31)
--------------------------

### Added

- Add the `KeywordColor` struct.


### Changed

- Change stylesheet keywords from UpperCamelCase to lowercase.


### Deprecated

- Deprecate `NSColor.stylesheetKeywordColors` in favor of `KeywordColor.stylesheetColors`.


2.7.1 (2022-02-04)
--------------------------

### Fixed

- Fix an issue where `SwiftUI.Color` ignored the alpha value in hexadecimal color codes.


2.7.0 (2021-05-08)
--------------------------

### Added

- Support creating SwiftUI `Color` values.


2.6.1 (2020-02-27)
--------------------------

### Changed

- Raise the minimum supported macOS version to 10.10.
- Improve the Package.swift declaration.


2.6.0 (2019-11-21)
--------------------------

### Changed

- Make the alpha value optional when initializing `NSColor`.
- Set the detected `type` inout parameter to `nil` when creating an `NSColor` from a color code fails.


### Fixed

- Fix a crash when initializing `NSColor` from a color code containing `.` as a floating-point value.


2.5.0 (2019-06-05)
--------------------------

### Fixed

- Fix Package.swift.


2.4.0 (2019-03-26)
--------------------------

### Changed

- Update code for Swift 5.0.


2.3.0 (2018-09-14)
--------------------------

### Changed

- Update code for Swift 4.2.


2.2.1 (2018-04-25)
--------------------------

### Fixed

- Fix `ColorCodeType` enum raw values.


2.2.0 (2018-04-25)
--------------------------

### Changed

- Remove the `.invalid` case from `ColorCodeType`.


2.1.3 (2018-03-30)
--------------------------

### Changed

- Update the project for Xcode 9.3.


2.1.2 (2017-11-15)
--------------------------

### Changed

- Tweak the implementation.

### Fixed

- Fix Swift Package Manager support.


2.1.0 (2017-11-06)
--------------------------

### Changed

- Update the project for Xcode 9.1.


2.0.4 (2017-07-10)
--------------------------

### Changed

- Update the project for Xcode 8.2.


2.0.1 (2016-10-28)
--------------------------

### Changed

- Update code for Swift 3.0.1.


2.0.0 (2016-09-10)
--------------------------

### Added

- Migrate the codebase to Swift.
- Provide `ColorCode` as a framework.
- Raise the minimum supported OS X version to 10.9.


1.3.0 (2015-09-10)
--------------------------

### Added

- Support Objective-C generics in Xcode 7.


1.2.0 (2015-09-03)
--------------------------

### Added

- Add the `WFColorCodeCSSKeyword` color code type.
- Add the `colorWithHex:alpha:` and `stylesheetKeywordColors` class methods.


### Changed

- Return `instancetype` instead of `NSColor`.


1.1.4 (2015-09-03)
--------------------------

### Changed

- Add more documentation.


1.1.3 (2015-05-11)
--------------------------

### Fixed

- Fix nullability annotations.


1.1.2 (2015-05-11)
--------------------------

### Changed

- Add nullability annotations to methods.


1.1.1 (2014-09-12)
--------------------------

### Changed

- Use `NSCalibratedRGBColorSpace` instead of `NSDeviceRGBColorSpace` when creating `NSColor` instances.


1.1 (2014-09-07)
--------------------------

### Added

- Add the `hslSaturationComponent` and `lightnessComponent` methods.

### Changed

- Add detailed documentation comments.


1.0 (2014-09-03)
--------------------------

- Initial release.
