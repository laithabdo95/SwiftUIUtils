// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let coreUtils = "https://Access2ArabiaDevOps@dev.azure.com/Access2ArabiaDevOps/A2AProjects/_git/CoreUtils"

let package = Package(
    name: "SwiftUIUtils",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SwiftUIUtils",
            targets: ["SwiftUIUtils"]),
    ],
    dependencies: [
        .package(url: coreUtils, branch: "upgrade"),
    ],
    targets: [
        .target(
            name: "SwiftUIUtils",
            dependencies: [
                .product(name: "CoreUtils", package: "CoreUtils"),
            ],
            resources: [
                .process("./Resources/Colors.xcassets")
            ]
        )
    ]
)
