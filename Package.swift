// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IASDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "IACore",
            targets: ["IACore"]),
        .library(
            name: "IAOverTheCounter",
            targets: ["IAOverTheCounterWrapper"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "IACore",
            url: "https://github.com/danijel-huis-4ofthem/TestRepo/releases/download/0.0.1/IACore-0.0.1.xcframework.zip",
            checksum: "6d79a0289928cb499d1d1271a1b24c5c4da69c55ab5526f09251adfe7c805fb4"
        ),
        .binaryTarget(
            name: "IAOverTheCounter",
            url: "https://github.com/danijel-huis-4ofthem/TestRepo/releases/download/0.0.1/IAOverTheCounter-0.0.1.xcframework.zip",
            checksum: "4bd8c7f66b7c0b4ec8eaea5e92841dc18aaabf6ee186bcd20496630597b5d24a"
        ),
        .target(
            name: "IAOverTheCounterWrapper",
            dependencies: [ 
                .target(name: "IACore"),
                .target(name: "IAOverTheCounter"),
            ],
            path: "Sources"
        )
    ]
)
