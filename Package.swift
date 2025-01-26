// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let otpify = "https://github.com/mehmetfarhan/Otpify"

let package = Package(
    name: "Utilities",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Utilities",
            targets: ["Utilities"]),
    ],
    dependencies: [
        .package(url: otpify, from: "1.0.1"),
    ],
    targets: [
        .target(
            name: "Utilities",
            dependencies: [
                "Otpify"
            ],
            resources: [
                .process("./Resources/Colors.xcassets")
            ]
        )
    ]
)
