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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2/VoxeetSDK.zip",
            checksum: "15e10eceeb6431200c758da6d383b7a3fff29bbf45ec65494ebe46f479784316"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2/WebRTC.zip",
            checksum: "4e9dc41e53d1de4680ae8c5fbcd52ba531de4c8117d35063c869d46bb23b3e26"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2/dvclient.zip",
            checksum: "01dba00cb7130ec3d73ec6c91cdb57a90c76e6be0bd859d5f091bb2f4f548a23"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2/dvdnr.zip",
            checksum: "6678d200ddead8adc9abc453f566e34137aaee112fbcbd7bd2a5a877012c3f0d"),
    ]
)
