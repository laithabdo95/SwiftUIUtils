// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let coreUtils = "https://Access2ArabiaDevOps@dev.azure.com/Access2ArabiaDevOps/A2AProjects/_git/CoreUtils"
let swiftUIIntrospect = "https://github.com/siteline/SwiftUI-Introspect"

let package = Package(
    name: "SwiftUIUtils",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SwiftUIUtils",
            targets: ["SwiftUIUtils"]),
    ],
    dependencies: [
        .package(url: coreUtils, branch: "main"),
        .package(url: swiftUIIntrospect, from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftUIUtils",
            dependencies: [
                .product(name: "CoreUtils", package: "CoreUtils"),
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
            ],
            resources: [
                .process("./Resources/Colors.xcassets")
            ]
        )
    ]
)
