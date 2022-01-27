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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3-beta.1/VoxeetSDK.zip",
            checksum: "1085a0625f32171dbf79c54102700147592927d0ffa24e1bcb0d33ec8322c714"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3-beta.1/WebRTC.zip",
            checksum: "afef17b52685fe26e25ef47a39525c5e42c462670f4bc5bb65ce788abd977ff9"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.3.3-beta.1/dvclient.zip",
            checksum: "337d53b9f41fca31e270b7161a305b305989146ec69ae5c574962aa9770b6a19"),
    ]
)
