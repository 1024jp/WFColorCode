// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ColorCode",
    platforms: [
        .macOS(.v10_10),
    ],
    products: [
        .library(name: "ColorCode", targets: ["ColorCode"]),
    ],
    targets: [
        .target(name: "ColorCode"),
        .testTarget(name: "ColorCodeTests", dependencies: ["ColorCode"]),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
