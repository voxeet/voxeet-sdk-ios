// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoxeetSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VoxeetSDK",
            targets: [
                "VoxeetSDK", 
                "WebRTC", 
                "dvclient", 
                "dvdnr", 
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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.3/VoxeetSDK.zip",
            checksum: "22bd9e183df8d685a6a3ed04c0c9edd7aa7caa38527e5a79fedaa0721c046139"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.3/WebRTC.zip",
            checksum: "4057bc48fafca65b853f3d6fa7910306a2c71675084a52830e79fa6c7746dc8d"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.3/dvclient.zip",
            checksum: "6a31ee6c73d65101bc406da3c46471c75acf9b9a2d53b8e951a753f88e2696bf"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.3/dvdnr.zip",
            checksum: "500e0d8443a33998c2f9523b24c172518e6b6edee2e69bead860f5ea8d427299"),
    ]
)
