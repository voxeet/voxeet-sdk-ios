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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.1/VoxeetSDK.zip",
            checksum: "ea605255cdd79cd6bb07a1298005c934d9089ba967130495d4b3fe564439fd0f"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.1/WebRTC.zip",
            checksum: "99d914766cd049724c65fe89c0796cd4c36a7a1f5c1146dd159d646b52a98bed"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.1/dvclient.zip",
            checksum: "adba3531747e4d8c95056ff994d120c2ba56e8519fedf1b856991fa116a9ced5"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.1/dvdnr.zip",
            checksum: "564e02efa81198e58f1d6330995f45b9b7ff8ce99ccde0d981d68d3ae27eefab"),
    ]
)
