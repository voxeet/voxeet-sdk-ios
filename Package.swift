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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.1/VoxeetSDK.zip",
            checksum: "a2faa94418618d31e10e6084fb1dcebc1c2e434d5d75e04472ef970796755285"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.1/WebRTC.zip",
            checksum: "0993650e20b249e586a0d92c452cf075088eb8715d2f299f13153240d651fa70"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.1/dvclient.zip",
            checksum: "3b745d7b8c71f01a63f51130e088de52f1ef47cbae062e349577c3acc91bd55e"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.1/dvdnr.zip",
            checksum: "a901e2014327ab6126eb3b63022ceb2442367e0d5e57466259fd2a8947b2b71c"),
    ]
)