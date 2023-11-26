// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(
            name: "CoreUtil",
            targets: ["CoreUtil"]
        ),
        .library(
            name: "RIBsUtil",
            targets: ["RIBsUtil"]
        ),
        .library(
            name: "RxUtil",
            targets: ["RxUtil"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", from: "0.9.7"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0"),
        
    ],
    targets: [
        .target(
            name: "CoreUtil"
        ),
        .target(
            name: "RIBsUtil",
            dependencies: [
                "RIBs"
            ]
        ),
        .target(
            name: "RxUtil",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
    ]
)
