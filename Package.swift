// swift-tools-version: 6.3
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
        .package(url: "https://github.com/apple/swift-numerics", from: Version(1, 0, 2)),
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
        .strictMemorySafety(),
        
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
