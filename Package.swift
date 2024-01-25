// swift-tools-version:5.9
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
    ]
)
