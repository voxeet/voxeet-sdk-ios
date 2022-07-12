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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.6.0-beta.2/VoxeetSDK.zip",
            checksum: "86e4554f5fd296acc5e76c4a02b81de3102c51774563d482398406ddf0635a50"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.6.0-beta.2/WebRTC.zip",
            checksum: "32b3311fbe8053f5028ea6db84d9feb832d3526e84ece7f1d6160b48f3f3dc4a"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.6.0-beta.2/dvclient.zip",
            checksum: "0039384aa95314b46c75b3a120b7e14e18383df73d9907191e1a3eb2d5f6783d"),
    ]
)