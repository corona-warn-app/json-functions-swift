// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jsonfunctions",
    platforms: [
        .macOS(.v10_13), .iOS(.v11), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "jsonfunctions",
            targets: ["jsonfunctions"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/clubspark-swift/AnyCodable",
            .revision("4133a623c4dc1d1ba9a107cc9bbee954ada16c6a")
        ),
    ],
    targets: [
        .target(
            name: "jsonfunctions",
            dependencies: ["AnyCodable"]),
        .testTarget(
            name: "jsonfunctionsTests",
            dependencies: ["jsonfunctions", "AnyCodable"],
            resources: [.process("jfn-common-test-cases.json")])
    ],
    swiftLanguageVersions: [.v5, .v4_2, .v4]
)
