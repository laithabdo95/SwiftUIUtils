// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SUIUtilities",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SUIUtilities",
            targets: ["SUIUtilities"]),
    ],
    targets: [
        .target(
            name: "SUIUtilities",
            resources: [
                .process("./Resources/Colors.xcassets")
            ]
        )
    ]
)
