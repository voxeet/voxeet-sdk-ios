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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0/VoxeetSDK.zip",
            checksum: "2d6f4da91528f44c8472f1d2cfe24a43fd368d90a556e050dbd5d6172f0413cc"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0/WebRTC.zip",
            checksum: "4782ce8c5d89ef00e1dc716e702d5385c7e144622d9c33142a975b8e5cf2f199"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0/dvclient.zip",
            checksum: "d12a918f5cc073794618b8cff3f64dddc018300145eef7f942cc8bd121e5a483"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.9.0/dvdnr.zip",
            checksum: "45a86ea46ead9f70b6a1c79c7013310fcdf047fe23664db4b8c5081e077a3b33"),
    ]
)
