// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(
            name: "Util", 
            targets: ["Util"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", from: "0.9.7")
    ],
    targets: [
        .target(
            name: "Util",
            dependencies: [
                "RIBs"
            ]
        ),
    ]
)
