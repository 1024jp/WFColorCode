// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ColorCode",
    platforms: [
        .macOS(.v11),
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
