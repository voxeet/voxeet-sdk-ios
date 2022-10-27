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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.1/VoxeetSDK.zip",
            checksum: "20f6ad36059c01aa8e2afc45baf0bfa29b22305370184cf9ae0c7f09766a2404"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.1/WebRTC.zip",
            checksum: "734681cc2451f5ef25ed11913bf1bf39369da56e10cf30a9fa325f8090146a4b"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.1/dvclient.zip",
            checksum: "ac6f3822be48a92d12c6d33fbd7da327ebb6e2affa8288fd02e5cbd5befc01c1"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.7.1/dvdnr.zip",
            checksum: "9d6d1e87d906199158bab5efff557e47220e505375ed3446f8c985c9b1370855"),
    ]
)