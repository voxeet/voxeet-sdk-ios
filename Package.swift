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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.0-beta.1/VoxeetSDK.zip",
            checksum: "e6fe5827561a7b09978348074c66f91aa4b211bc347363398e8bdfb305dcc3f0"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.0-beta.1/WebRTC.zip",
            checksum: "d5b79a7436dda5330ec029741b5a8492ec4e92dd41471df464f4e4fed7d2c8ca"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.0-beta.1/dvclient.zip",
            checksum: "dc28f409a40565f1d3af13304ca96f20388304877bb9e01548379c1172eb200d"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.0-beta.1/dvdnr.zip",
            checksum: "d283d4540b908e2766a30e2b2d3a8a3457714ccabd2f27215996922a09bc0c95"),
    ]
)
