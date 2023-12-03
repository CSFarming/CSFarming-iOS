// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Service",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BaseService",
            targets: ["BaseService"]
        ),
        .library(
            name: "HomeService",
            targets: ["HomeService"]
        ),
        .library(
            name: "MarkdownService",
            targets: ["MarkdownService"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0")
    ],
    targets: [
        .target(
            name: "BaseService",
            dependencies: [
                "Moya"
            ]
        ),
        .target(
            name: "HomeService",
            dependencies: [
                "BaseService",
                "Moya",
                "SwiftSoup"
            ]
        ),
        .target(
            name: "MarkdownService",
            dependencies: [
                "BaseService",
                "Moya"
            ]
        )
    ]
)
