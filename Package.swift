// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AwesomeUtilities",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "AwesomeUtilities",
            targets: ["AwesomeUtilities"]
        ),
        .library(
            name: "AwesomeUtilitiesTests",
            targets: ["AwesomeUtilitiesTests"]
        )
    ],
    targets: [
        .target(
            name: "AwesomeUtilities",
            path: "Source",
            sources: ["Core", "Extensions"]
        ),
        .target(
            name: "AwesomeUtilitiesTests",
            dependencies: ["AwesomeUtilities"],
            path: "Source/Tests"
        )
    ]
)
