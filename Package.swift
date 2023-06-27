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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.0/VoxeetSDK.zip",
            checksum: "fd20d406cd7b13069f7e3907ae6d90fdd4a9b432ef4f08400a96ffcb071d3439"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.0/WebRTC.zip",
            checksum: "d67d7b78476e7bc65f686af012559b4cda237648a6f2d36e5dae45db32848931"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.0/dvclient.zip",
            checksum: "5e0d68437bb8f6cee97aeaf88c251afb2ebfcac4197299337bb5228d1a6a434c"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.10.0/dvdnr.zip",
            checksum: "7601129bdd99def6a8e5aa2f729917f8e6086d30e1ddf6cd5a2f94a9d0b90c39"),
    ]
)
