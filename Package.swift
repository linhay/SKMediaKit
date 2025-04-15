// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SKMediaKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SKMediaKit", targets: ["SKMediaKit"]),
        .library(name: "SKMediaUI", targets: ["SKMediaUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kingslay/KSPlayer.git", from: "2.3.4"),
    ],
    targets: [
        .target(name: "SKMediaKit",
                dependencies: [
                    .product(name: "KSPlayer", package: "KSPlayer"),
                    "SKMediaUI"
                ]),
        .target(name: "SKMediaUI",
                dependencies: [])
    ]
)
