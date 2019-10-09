// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Meta",
    platforms: [.macOS(.v10_14)],
    products: [
        .library(name: "Meta", targets: ["Meta"]),
        .executable(name: "generate-optics", targets: ["OpticsGenerator"])
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
        .package(url: "https://github.com/bow-swift/bow.git", .exact("0.6.0")),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", .exact("1.6.0")),
    ],

    targets: [
        // Library targets
        .target(name: "Meta",
                dependencies: ["SwiftSyntax", "Bow", "BowEffects"]),
        .target(name: "OpticsGenerator",
                dependencies: ["Meta"]),

        // Test targets
        .testTarget(name: "MetaTests",
                    dependencies: ["Meta", "SnapshotTesting"])
    ]
)
