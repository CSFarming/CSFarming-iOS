// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
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
        .library(
            name: "Problem",
            targets: ["Problem"]
        ),
        .library(
            name: "ProblemInterface",
            targets: ["ProblemInterface"]
        ),
        .library(
            name: "MarkdownContent",
            targets: ["MarkdownContent"]
        ),
        .library(
            name: "MarkdownContentInterface",
            targets: ["MarkdownContentInterface"]
        ),
        .library(
            name: "Archive",
            targets: ["Archive"]
        ),
        .library(
            name: "ArchiveInterface",
            targets: ["ArchiveInterface"]
        ),
        .library(
            name: "Question",
            targets: ["Question"]
        ),
        .library(
            name: "QuestionInterface",
            targets: ["QuestionInterface"]
        ),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../DesignKit"),
        .package(path: "../Service"),
        .package(url: "https://github.com/uber/RIBs", from: "0.9.7"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.6.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.6.0"),
        .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", from: "2.2.0")
    ],
    targets: [
        .target(
            name: "BasePresentation",
            dependencies: [
                "RxSwift",
                "DesignKit",
                .product(name: "RxCocoa", package: "RxSwift")
            ]
        ),
        .target(
            name: "Home",
            dependencies: [
                "BasePresentation",
                "HomeInterface",
                "MarkdownContentInterface",
                .product(name: "CoreUtil", package: "Core"),
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                .product(name: "HomeService", package: "Service"),
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
        ),
        .target(
            name: "Problem",
            dependencies: [
                "BasePresentation",
                "ProblemInterface",
                "QuestionInterface",
                .product(name: "CoreUtil", package: "Core"),
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                .product(name: "ProblemService", package: "Service"),
                "DesignKit",
                "RIBs",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
            ]
        ),
        .target(
            name: "ProblemInterface",
            dependencies: [
                "RIBs"
            ]
        ),
        .target(
            name: "MarkdownContent",
            dependencies: [
                "BasePresentation",
                "MarkdownContentInterface",
                .product(name: "CoreUtil", package: "Core"),
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                .product(name: "MarkdownService", package: "Service"),
                "DesignKit",
                "RIBs",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "MarkdownUI", package: "swift-markdown-ui"),
                "SnapKit",
            ]
        ),
        .target(
            name: "MarkdownContentInterface",
            dependencies: [
                "RIBs"
            ]
        ),
        .target(
            name: "Archive",
            dependencies: [
                "BasePresentation",
                "ArchiveInterface",
                "MarkdownContentInterface",
                .product(name: "CoreUtil", package: "Core"),
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                .product(name: "ArchiveService", package: "Service"),
                "DesignKit",
                "RIBs",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
            ]
        ),
        .target(
            name: "ArchiveInterface",
            dependencies: [
                "RIBs"
            ]
        ),
        .target(
            name: "Question",
            dependencies: [
                "BasePresentation",
                "QuestionInterface",
                .product(name: "CoreUtil", package: "Core"),
                .product(name: "RIBsUtil", package: "Core"),
                .product(name: "RxUtil", package: "Core"),
                .product(name: "QuestionService", package: "Service"),
                "DesignKit",
                "RIBs",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
            ]
        ),
        .target(
            name: "QuestionInterface",
            dependencies: [
                "RIBs"
            ]
        ),
    ]
)
