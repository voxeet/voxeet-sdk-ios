Pod::Spec.new do |spec|
  spec.name = "VoxeetSDK"
  spec.version = "3.2.1-beta.1"
  spec.summary = "Voxeet provides a platform for unified communications and collaboration."
  spec.license = "Dolby Software License Agreement"
  spec.author = "Voxeet"
  spec.homepage = "https://dolby.io"
  spec.platform = :ios, "11.0"
  spec.swift_version = "5.5"
  spec.source = { :http => "https://vox-ios-sdk.s3.us-east-1.amazonaws.com/sdk/ios/release/v#{spec.version}/VoxeetSDK.zip" }
  spec.vendored_frameworks = "VoxeetSDK.framework", "WebRTC.framework", "dvclient.framework"

  # MacBook arm simulator isn't supported.
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'ENABLE_BITCODE' => 'NO' # Disable bitcode to support dvclient.framework dependency.
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
