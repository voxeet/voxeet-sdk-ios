// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoxeetSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VoxeetSDK",
            targets: ["VoxeetSDK", "WebRTC", "dvclient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "VoxeetSDK",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3/VoxeetSDK.zip",
            checksum: "8d3aea8455b4c7edaa2e5a41098f1b774cf7e1789aa13046b0ae5e7026c57950"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3/WebRTC.zip",
            checksum: "8942b78134eb6d3b7e2deb0d76ec750e8323157e70f27a6bec4366f91f20d7b1"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3/dvclient.zip",
            checksum: "b37a17a0e78dfe3e285438076cfc28be5604a4cbd792de0946198b4fc9b4ce28"),
    ]
)
