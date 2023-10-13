// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIKitExtension",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "SwiftUIKitExtension",
            targets: ["SwiftUIKitExtension"]
        ),
    ],
    dependencies: [
        .package(
            name: "SwiftQuartzCoreExtension",
            url: "https://github.com/hcmc-studio/swift-quartz-core-extension.git",
            branch: "0.0.55"
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIKitExtension",
            dependencies: ["SwiftQuartzCoreExtension"]
        ),
        .testTarget(
            name: "SwiftUIKitExtensionTests",
            dependencies: ["SwiftUIKitExtension"]
        ),
    ]
)
