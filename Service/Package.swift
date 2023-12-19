// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Service",
    platforms: [.iOS(.v17)],
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
            name: "HomeServiceTestUtil",
            targets: ["HomeServiceTestUtil"]
        ),
        .library(
            name: "MarkdownService",
            targets: ["MarkdownService"]
        ),
        .library(
            name: "MarkdownServiceTestUtil",
            targets: ["MarkdownServiceTestUtil"]
        ),
        .library(
            name: "ArchiveService",
            targets: ["ArchiveService"]
        ),
        .library(
            name: "ArchiveServiceTestUtil",
            targets: ["ArchiveServiceTestUtil"]
        ),
        .library(
            name: "ProblemService",
            targets: ["ProblemService"]
        ),
        .library(
            name: "QuestionService",
            targets: ["QuestionService"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.6.0"),
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
            name: "HomeServiceTestUtil",
            dependencies: [
                "RxSwift",
                "BaseService",
                "HomeService"
            ]
        ),
        .target(
            name: "MarkdownService",
            dependencies: [
                "BaseService",
                "Moya"
            ]
        ),
        .target(
            name: "MarkdownServiceTestUtil",
            dependencies: [
                "RxSwift",
                "BaseService",
                "MarkdownService"
            ]
        ),
        .target(
            name: "ArchiveService",
            dependencies: [
                "BaseService",
                "Moya",
                "SwiftSoup"
            ]
        ),
        .target(
            name: "ArchiveServiceTestUtil",
            dependencies: [
                "RxSwift",
                "BaseService",
                "ArchiveService"
            ]
        ),
        .target(
            name: "ProblemService",
            dependencies: [
                "BaseService",
                "Moya",
            ]
        ),
        .target(
            name: "QuestionService",
            dependencies: [
                "BaseService",
                "Moya"
            ]
        )
    ]
)
