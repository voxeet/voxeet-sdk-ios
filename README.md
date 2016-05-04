# Voxeet iOS SDK

The SDK is a Swift library allowing users to:

  - Create demo/normal conferences
  - Join conferences
  - Change sounds angle and direction for each conference user
  - Broadcast messages to other participants

## Requirements

  - iOS 8.0+
  - Xcode 7.3+

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
pod 'VoxeetSDK', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

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

## Usage

### Initializing  
  
```swift
VoxeetSDK.sharedInstance.initializeSDK("consumerKey", consumerSecret: "consumerSecret")
```

### Creating a demo conference  

```swift
VoxeetSDK.sharedInstance.createDemoConference { (error) in 
}
```

### Creating a conference  

```swift
VoxeetSDK.sharedInstance.createConference(success: { (confID, confAlias) in
    }, fail: { (error) in
})
```

### Joining a conference  

```swift
VoxeetSDK.sharedInstance.joinConference(conferenceID: confID) { (error) in
}
```

```swift
VoxeetSDK.sharedInstance.joinConference(conferenceAlias: confAlias) { (error) in
}
```

### Leaving a conference  

```swift
VoxeetSDK.sharedInstance.leaveConference { (error) in
}
```

### Changing user position  

```swift
// Values for angle and distance are between: angle = [-1, 1] and distance = [0, 1]
VoxeetSDK.sharedInstance.setUserPosition("userID", angle: 0, distance: 0)
```

```swift
VoxeetSDK.sharedInstance.setUserAngle("userID", angle: 0)
```

```swift
VoxeetSDK.sharedInstance.setUserDistance("userID", distance: 0)
```

### Getting a specific user position

```swift
let (angle, distance) = VoxeetSDK.sharedInstance.getUserPosition("userID")
```

### Getting current conference users

```swift
let users = VoxeetSDK.sharedInstance.getConferenceUsers()
```

### Sending message in a conference

```swift
VoxeetSDK.sharedInstance.sendMessage("message", completion: { (error) in
})
```

## Available delegates / callbacks

### Session

```swift
class myClass: VTSessionStateDelegate {
    func didSessionStateChanged(state: VoxeetSDK.SessionState) {
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
    func userDidJoin(userID: String) {
    }
    
    func userDidLeft(userID: String) {
    }
    
    func messageReceived(userID: String, message: String) {
    }
}
```
or
```swift
VoxeetSDK.sharedInstance.userDidJoin = { userID in
}
        
VoxeetSDK.sharedInstance.userDidLeft = { userID in
}
        
VoxeetSDK.sharedInstance.messageReceived = { userID, message in
}
```

## Available enums

### Session state:

```swift
public enum SessionState {
        case NotConnected
        case Connected
        case Connecting
        case Reconnecting
    }
```

### Error handler:

```swift
public enum VTErrorType: ErrorType {
    case Credential(String)
    case InternalServer
    case AccessToken
    case Identify
    case LeaveConference
    case CreateConference
    case JoinConference
    case SendBroadcastMessage
    case ServerError(String?)
    case Error(ErrorType?)
}
```

## Version
0.8.0

## Tech

The Voxeet iOS SDK uses a number of open source projects to work properly:

* [Starscream](https://github.com/daltoniam/Starscream) - Starscream is a conforming WebSocket (RFC 6455) client library in Swift for iOS and OSX.
* [Alamofire](https://github.com/Alamofire/Alamofire) - Alamofire is an HTTP networking library written in Swift.
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON makes it easy to deal with JSON data in Swift.

## Sample Application

A sample application is available on this [public repository](https://github.com/voxeet/ios-sdk-sample/tree/master/Sample) on GitHub.
