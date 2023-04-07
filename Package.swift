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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0-beta.1/VoxeetSDK.zip",
            checksum: "211de45c2251fddfd7067282d7d0868baee7171e901195ec306f0ca1ab37ed72"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0-beta.1/WebRTC.zip",
            checksum: "ec9565aa762fde230f0a15bc3f322f4966ac26123501abbb0e125d294c835687"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0-beta.1/dvclient.zip",
            checksum: "550739bd00404a3c4d5c2806cd08e2d9fcb0b21a192531759755f1f64afd36d5"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0-beta.1/dvdnr.zip",
            checksum: "d4ed8951cffd3904bfbe95f8bfc2f1179420887374eb256213c0ae22f86e6b10"),
    ]
)
