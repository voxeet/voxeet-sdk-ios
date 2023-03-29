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
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2-beta.1/VoxeetSDK.zip",
            checksum: "8e83452ad0479765b5bb51c8d6498e6c4d58588642af6a8d4a5643a2c79c9a83"),
        .binaryTarget(
            name: "WebRTC",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2-beta.1/WebRTC.zip",
            checksum: "4fb8a65fde3901a4147a82e9ebca4b6831aa772f9bf033f593ae78ffce769a84"),
        .binaryTarget(
            name: "dvclient",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2-beta.1/dvclient.zip",
            checksum: "bcd0bdb1a799a002f3384cd35a17a4232b4edaeeb57da6f0e2b68464577f8ba2"),
        .binaryTarget(
            name: "dvdnr",
            url: "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/voxeetsdk/release/3.8.2-beta.1/dvdnr.zip",
            checksum: "031abdf5eaf9061e53673a961807e77a5a42afa3b2768e98108490a8f0140b6d"),
    ]
)
