// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RxUserDefaults",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "RxUserDefaults",
            targets: ["RxUserDefaults"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.9.0"),
    ],
    targets: [
        .target(
            name: "RxUserDefaults",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "RxUserDefaultsTests",
            dependencies: ["RxUserDefaults"]
        ),
    ]
)
