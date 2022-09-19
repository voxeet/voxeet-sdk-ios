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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.3/VoxeetSDK.zip",
            checksum: "3a746ce593bd47c473f90c98d2d5a73044558cdd35c0e9ef32e2fce297690138"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.3/WebRTC.zip",
            checksum: "fb1b4b536c953c7dcd574b7b0a6cc73f9c8ad970c7da8f8443713e12babd3cb7"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.3/dvclient.zip",
            checksum: "1f8cd861e14386c56ea29cf39fe2cbd03b42114e7fac7abb8275039e739bfc11"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.0-beta.3/dvdnr.zip",
            checksum: "38aae378f679ae0397cfc720183edef29e5f1e95afe2e979988d903f5949c002"),
    ]
)