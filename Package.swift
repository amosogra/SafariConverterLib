// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to
// build this package.

import PackageDescription

let package = Package(
    name: "ContentBlockerConverter",
    products: [
        .library(
            name: "ContentBlockerConverter",
            targets: ["ContentBlockerConverter", "FilterEngine"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/gumob/PunycodeSwift.git", exact: "3.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.5.0"),
        .package(url: "https://github.com/amosogra/swift-psl", exact: "v2.0.0"),
    ],
    targets: [ 
        .target(
            name: "ContentBlockerConverter",
            dependencies: [
                .product(name: "Punycode", package: "PunycodeSwift")
            ]
        ),
        .target(
            name: "FilterEngine",
            dependencies: [
                "ContentBlockerConverter",
                .product(name: "PublicSuffixList", package: "swift-psl"),
            ]
        ),
        .testTarget(
            name: "ContentBlockerConverterTests",
            dependencies: ["ContentBlockerConverter"],
            resources: [.copy("Resources/test-rules.txt")]
        ),
        .testTarget(
            name: "FilterEngineTests",
            dependencies: ["FilterEngine"],
            resources: [
                .copy("Resources/advanced-rules.txt"),
                .copy("Resources/reference-rules.bin"),
                .copy("Resources/reference-engine.bin"),
            ]
        ),
    ]
)
