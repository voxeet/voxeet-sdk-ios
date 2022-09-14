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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.2/VoxeetSDK.zip",
            checksum: "933637a81b9d56d9d38fbc93c4c9adfff83707337717d531fa88672232f6843a"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.2/WebRTC.zip",
            checksum: "e280e96629de3f7a9212a7ba2a1d1d12bdfccf0ae3a44102b0a30d33966741a4"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.2/dvclient.zip",
            checksum: "d51c97e3943ee02d1def58532184d0dc7b797fcde69687562f8609244c1723c3"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.2/dvdnr.zip",
            checksum: "38270be159a8467983df5b1b47643773066dc9a2312f1df165bfdd2b417c106f"),
    ]
)