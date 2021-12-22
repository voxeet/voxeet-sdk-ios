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
            targets: ["VoxeetSDK", "WebRTC", "dvclient"]),
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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.3.2/VoxeetSDK.zip",
            checksum: "aeea312b41be2d0e37fc53afb7a23800db24822e2ee76e4b96fad07a2def7779"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.3.2/WebRTC.zip",
            checksum: "a5e7fb8c6aa989dbb0a3ee9906fa2aee9ffdf382ab7385071c228e5ee7d9f9ae"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/v3.3.2/dvclient.zip",
            checksum: "b55a2a9a519b124b8637465386c046ff56d015f79d4a4dc5728f133dc45bf537"),
    ]
)
