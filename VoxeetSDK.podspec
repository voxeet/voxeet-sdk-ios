Pod::Spec.new do |spec|
  spec.name = "VoxeetSDK"
  spec.version = "3.0.0-beta.2"
  spec.summary = "Voxeet provides a platform for unified communications and collaboration."
  spec.license = "MIT"
  spec.author = "Voxeet"
  spec.homepage = "https://dolby.io"
  spec.platform = :ios, "11.0"
  spec.swift_version = "5.3"
  spec.source = { :http => "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/sdk/ios/release/v#{spec.version}/VoxeetSDK.zip" }
  spec.vendored_frameworks = "VoxeetSDK.framework", "WebRTC.framework", "dvclient.framework"

  # MacBook arm simulator isn't supported.
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
