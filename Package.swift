// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ColorCode",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(name: "ColorCode", targets: ["ColorCode"]),
    ],
    targets: [
        .target(name: "ColorCode"),
        .testTarget(name: "ColorCodeTests", dependencies: ["ColorCode"])
    ],
    swiftLanguageVersions: [.v6]
)
