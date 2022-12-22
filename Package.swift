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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.4/VoxeetSDK.zip",
            checksum: "40ce136b21d6c672c2dcf9f60278aba939f455e9b1ddec43acb66c171770f8c4"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.4/WebRTC.zip",
            checksum: "fefa708a384eb1758947d8484281b29b744cccfe539baf36b970dd93c8bccfdf"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.4/dvclient.zip",
            checksum: "18893f5bef0682f92b194d501c212ee72c10bbf73b9625a1a40e129899960e15"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.4/dvdnr.zip",
            checksum: "1f1fbb41637f01355d10a7f71be91766ff1cd348280755c669332cfaad62ce87"),
    ]
)