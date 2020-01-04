// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ColorCode",
    platforms: [
        .macOS("10.9"),
    ],
    products: [
        .library(name: "ColorCode", targets: ["ColorCode"]),
    ],
    targets: [
        .target(name: "ColorCode"),
        .testTarget(name: "ColorCodeTests", dependencies: ["ColorCode"]),
    ]
)
