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
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: Version(0, 57, 0)),
    ],
    targets: [
        .target(name: "ColorCode"),
        .testTarget(name: "ColorCodeTests", dependencies: [
            "ColorCode",
            .product(name: "Numerics", package: "swift-numerics"),
        ])
    ]
)


for target in package.targets {
    target.plugins = [
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"),
    ]
    target.swiftSettings = [
        .enableUpcomingFeature("ExistentialAny"),
    ]
}
