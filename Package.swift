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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.1/VoxeetSDK.zip",
            checksum: "77a973f381a29ff5846e57ddf31b51098c0f9917f30137b30978f9c734cfcf7e"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.1/WebRTC.zip",
            checksum: "f55f4cb67be85b35554424f3859eb2cf33f2c31c2ed0688a25809efbb4cc3cf9"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.4.0-beta.1/dvclient.zip",
            checksum: "b2f4c94f18530e35fb455ce8e03796c247a4b40ea71008603eff3fc3c594409b"),
    ]
)