// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "HTTPClientNetworking",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "HTTPClientNetworking",
            targets: ["HTTPClientNetworking"]),
    ],
    targets: [
        .target(
            name: "HTTPClientNetworking"),
        .testTarget(
            name: "HTTPClientNetworkingTests",
            dependencies: ["HTTPClientNetworking"]
        ),
    ]
)
