// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ColorCode",
    targets: [
        .target(name: "ColorCode"),
        .testTarget(name: "ColorCodeTests", dependencies: ["ColorCode"]),
    ]
)
