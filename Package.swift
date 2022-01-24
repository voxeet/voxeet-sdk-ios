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
            targets: [
                "VoxeetSDK", 
                "WebRTC", 
                "dvclient", 
            ]
        ),
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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.2/VoxeetSDK.zip",
            checksum: "ee2b054e4de8f82760892bfe9d8cd6311d837bf9984b71f6176375a29ed829ca"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.2/WebRTC.zip",
            checksum: "336f91e4a8f7a332b35b20fa75d68062735a54b8da9bc996282929bf7b235b3a"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.2/dvclient.zip",
            checksum: "589593961c66ed1f668fff927aa0493a6c81a65ee98a421e441e485fb4ac03c1"),
    ]
)