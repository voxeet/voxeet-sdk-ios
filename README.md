# Voxeet iOS SDK

The SDK is a Swift library allowing users to:

  - Create demo/normal conferences
  - Join conferences
  - Change sounds angle and direction for each conference user
  - Broadcast messages to other participants

## Table of contents

  1. [Requirements](#requirements)
  1. [Sample Application](#sample-application)
  1. [Installing the iOS SDK](#installing-the-ios-sdk)
  1. [SDK Initialization](#sdk-initialization)
  1. [SDK Usage](#sdk-usage)
  1. [VTAudioSound Usage](#vtaudiosound-usage)
  1. [Available delegates / callbacks](#available-delegates-callbacks)

## Requirements

  - iOS 8.0+
  - Xcode 7.3+

## Sample Application

A sample application is available on this [public repository](https://github.com/voxeet/ios-sdk-sample/tree/master/Sample) on GitHub.

## Installing the iOS SDK

You need to disable Bitcode in your Xcode target settings: 'Build Settings' -> 'Enable Bitcode' -> No

To enable background mode, go to your target settings -> 'Capabilities' -> 'Background Modes'  
Turn on 'Audio, AirPlay and Picture in Picture'  
Turn on 'Voice over IP'

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate VoxeetSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

target "YourTarget" do
       pod 'VoxeetSDK', '~> 1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate VoxeetSDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "voxeet/ios-sdk-sample" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `VoxeetSDK.framework` into your Xcode project.

## SDK Initialization

Initialize the SDK in the AppDelegate.swift of your application:

```swift
import VoxeetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        // Initialization of the Voxeet SDK.
        VoxeetSDK.sharedInstance.initializeSDK("consumerKey", consumerSecret: "consumerSecret")

        return true
    }
    
    ...
}
```

## SDK Usage

### Initializing

```swift
VoxeetSDK.sharedInstance.initializeSDK("consumerKey", consumerSecret: "consumerSecret")
```

If you use external login like O365, LDAP, or custom login to retrieve contact details it's now possible to also add your contact ID with the display name and the photo URL avatar.  
This allows you to ask guest users to introduce themselves and provide their display name and for your authenticated users in your enterprise or for your clients the ID that can be retrieved from O365 (name, department, etc).

```swift
VoxeetSDK.sharedInstance.initializeSDK("consumerKey", consumerSecret: "consumerSecret", externalID: "ID", name: "name", avatarURL: "URL")
```

### Creating a demo conference

```swift
VoxeetSDK.sharedInstance.conference.createDemo { (error) in 
}
```

### Creating a conference

```swift
VoxeetSDK.sharedInstance.conference.create(success: { (confID, confAlias) in
    }, fail: { (error) in
})
```

### Joining a conference

```swift
VoxeetSDK.sharedInstance.conference.join(conferenceID: confID) { (error) in
}
```

```swift
VoxeetSDK.sharedInstance.conference.join(conferenceAlias: confAlias) { (error) in
}
```

### Leaving a conference

```swift
VoxeetSDK.sharedInstance.conference.leave { (error) in
}
```

### Changing user position

```swift
// Values for angle and distance are between: angle = [-1, 1] and distance = [0, 1]
VoxeetSDK.sharedInstance.conference.setUserPosition("userID", angle: 0, distance: 0)
```

```swift
VoxeetSDK.sharedInstance.conference.setUserAngle("userID", angle: 0)
```

```swift
VoxeetSDK.sharedInstance.conference.setUserDistance("userID", distance: 0)
```

### Getting a specific user position

```swift
let (angle, distance) = VoxeetSDK.sharedInstance.conference.getUserPosition("userID")
```

### Getting current conference users

```swift
let users = VoxeetSDK.sharedInstance.conference.getConferenceUsers()
```

### Sending broadcast message in a conference

```swift
VoxeetSDK.sharedInstance.conference.sendBroadcastMessage("message", completion: { (error) in
})
```

### Muting / Unmuting a user

```swift
VoxeetSDK.sharedInstance.conference.muteUser("userID", mute: true)
```

### Checking if a user is muted

```swift
let isMute = VoxeetSDK.sharedInstance.conference.isUserMuted("userID")
```

### Changing output device

```swift
if VoxeetSDK.sharedInstance.conference.setOutputDevice(VTOutputDeviceType.BuildInReceiver) {
    print("The output device has been changed.")
}
```

### Getting output devices

```swift
let (currentOutputDevice, availableOutputDevices) = VoxeetSDK.sharedInstance.conference.getOutputDevices()
```

### Connecting the SDK with the API (manually)

This optional method is automatically called before a regular request anyway. For example 'createDemoConference' calls internally 'connect'.

```swift
VoxeetSDK.sharedInstance.connect { (error) in
}
```

### Disonnecting the SDK with the API (manually)

This optional method can help to disconnect the SDK if you don't use it anymore.

```swift
VoxeetSDK.sharedInstance.disconnect { (error) in
}
```

## Available delegates / callbacks

### Session

```swift
class myClass: VTSessionStateDelegate {
    init() {
        // Session delegate.
        VoxeetSDK.sharedInstance.sessionStateDelegate = self
    }

    func didSessionStateChanged(state: VTSessionState) {
    }
}
```
or
```swift
VoxeetSDK.sharedInstance.didSessionChanged = { state in
}
```

### Conference

```swift
class myClass: VTConferenceDelegate {
    init() {
        // Conference delegate.
        VoxeetSDK.sharedInstance.conference.delegate = self
    }

    func userDidJoin(userID: String, userInfo: [String: String]) {
    }
    
    func userDidLeft(userID: String, userInfo: [String: String]) {
    }
    
    func messageReceived(userID: String, userInfo: [String: String], message: String) {
    }
}
```
or
```swift
VoxeetSDK.sharedInstance.conference.userDidJoin = { (userID, userInfo) in
}
        
VoxeetSDK.sharedInstance.conference.userDidLeft = { (userID, userInfo) in
}
        
VoxeetSDK.sharedInstance.conference.messageReceived = { (userID, userInfo, message) in
}
```

## Available enums

### Session state:

```swift
public enum VTSessionState {
    case NotConnected
    case Connected
    case Connecting
    case Reconnecting
}
```

### Output devices:

```swift
public enum VTOutputDeviceType: Int {
    case BuildInReceiver
    case BuiltInSpeaker
    case Headset
    case LineOut
    case Bluetooth
    case CarAudio
    case HDMI
    case AirPlay
}
```

### Error handler:

```swift
public enum VTErrorType: ErrorType {
    case Credential(String)
    case InternalServer
    case AccessToken
    case LeaveConference
    case CreateConference
    case JoinConference
    case SendBroadcastMessage
    case ServerError(String?)
    case Error(ErrorType?)
}
```

## VTAudioSound Usage

VTAudioSound helps you to play a 3DHD sound into your application.  
The sound must be encoded in **mono** to be played spatialized.

### Initializing

```swift
var sound: VTAudioSound?

if let path = NSBundle.mainBundle().pathForResource("myFile", ofType: "mp3") {
    do {
        sound = try VTAudioSound(url: NSURL(fileURLWithPath: path))
    } catch let error {
        // Debug.
        print("::DEBUG:: \(error)")
    }
}
```

### Playing sound

```swift
try? sound?.play() {
    // Debug.
    print("::DEBUG:: The sound has finished being played.")
}
```

### Stopping sound

```swift
sound?.stop()
```

### Checking if the sound is playing

```swift
let isPlaying = sound?.isPlaying
```

### Looping on the current sound

```swift
sound?.loop = true
```

### Getting filename of the sound

```swift
let filename = sound?.filename
```

### Setting / Getting volume

```swift
// The range of valid values are from 0.0 to 1.0.
sound?.volume = 1
```

```swift
let volume = sound?.volume
```

### Setting / Getting angle

```swift
// The range of valid values are from -1.0 to 1.0.
sound?.angle = 0
```

```swift
let angle = sound?.angle
```

### Setting / Getting distance

```swift
// The range of valid values are from 0.0 to 1.0.
sound?.distance = 0
```

```swift
let distance = sound?.distance
```

## Version

1.0.1.6

## Tech

The Voxeet iOS SDK uses a number of open source projects to work properly:

* [Starscream](https://github.com/daltoniam/Starscream) - Starscream is a conforming WebSocket (RFC 6455) client library in Swift for iOS and OSX.
* [Alamofire](https://github.com/Alamofire/Alamofire) - Alamofire is an HTTP networking library written in Swift.
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON makes it easy to deal with JSON data in Swift.
* [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) - Crypto related functions and helpers for Swift implemented in Swift.

© Voxeet, 2016