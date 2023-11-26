// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BasePresentation",
            targets: ["BasePresentation"]
        ),
        .library(
            name: "Home",
            targets: ["Home"]
        ),
        .library(
            name: "HomeInterface",
            targets: ["HomeInterface"]
        ),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../DesignKit"),
        .package(url: "https://github.com/uber/RIBs", from: "0.9.7"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.6.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.6.0")
    ],
    targets: [
        .target(
            name: "BasePresentation",
            dependencies: [
                "RxSwift"
            ]
        ),
        .target(
            name: "Home",
            dependencies: [
                "BasePresentation",
                "HomeInterface",
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                "DesignKit",
                "RIBs",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
            ]
        ),
        .target(
            name: "HomeInterface",
            dependencies: [
                "RIBs"
            ]
        )
    ]
)
