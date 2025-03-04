// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "IASDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "IACore",
            targets: ["IACore"]
        ),
        .library(
            name: "IAOverTheCounter",
            targets: ["IAOverTheCounterWrapperTarget"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.1-beta1/IACore-0.0.1.xcframework.zip",
            checksum: "d0c351faf69eb9f21810d3f492b478ee2a0322c6871d6a0bfae07ee870841048"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.1-beta1/IAOverTheCounter-0.0.1.xcframework.zip",
            checksum: "429df1ad0f2e2b0a4e4673a59ba2761c6cde3376acad48f8bf7ebd2f7d21f905"
        ),
        .target(
            name: "IAOverTheCounterWrapperTarget",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "IAOverTheCounterWrapperTarget"
        )
    ]
)

