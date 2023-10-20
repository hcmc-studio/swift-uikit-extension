// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIKitExtension",
    platforms: [
        .iOS("15.0"),
        .macOS("10.15")
    ],
    products: [
        .library(
            name: "SwiftUIKitExtension",
            targets: ["SwiftUIKitExtension"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/hcmc-studio/swift-concurrency-extension.git",
            branch: "0.0.59"
        ),
        .package(
            url: "https://github.com/hcmc-studio/swift-quartz-core-extension.git",
            branch: "0.0.59"
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIKitExtension",
            dependencies: [
                .product(name: "SwiftConcurrencyExtension", package: "swift-concurrency-extension"),
                .product(name: "SwiftQuartzCoreExtension", package: "swift-quartz-core-extension")
            ]
        ),
        .testTarget(
            name: "SwiftUIKitExtensionTests",
            dependencies: ["SwiftUIKitExtension"]
        ),
    ]
)
