// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIUtils",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SwiftUIUtils",
            targets: ["SwiftUIUtils"]),
    ],
    targets: [
        .target(
            name: "SwiftUIUtils",
            resources: [
                .process("./Resources/Colors.xcassets")
            ]
        )
    ]
)
