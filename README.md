# Voxeet iOS SDK

![Voxeet SDK logo](http://www.voxeet.com/wp-content/uploads/2016/05/SDK-API-768x180.png "Voxeet SDK logo")

The Voxeet SDK is a Swift library allowing users to:

  - Create demo/normal conferences
  - Join conferences
  - Change sounds angle and direction for each conference user
  - Broadcast messages to other participants
  - Send and receive video stream

## Table of contents

  1. [Requirements](#requirements)
  1. [Sample Application](#sample-application)
  1. [Installing the iOS SDK](#installing-the-ios-sdk)
  1. [SDK Initialization](#sdk-initialization)
  1. [SDK Usage](#sdk-usage)
  1. [VTAudioSound Usage](#vtaudiosound-usage)
  1. [Available delegates / callbacks](#available-delegates-callbacks)
  1. [Publish your app with the Voxeet SDK](#publish-your-app-with-the-voxeet-sdk)

## Requirements

  - iOS 9.0+
  - Xcode 8.0+
  - Swift 3.0.1+

## Sample Application

A sample application is available on this [public repository](https://github.com/voxeet/ios-sdk-sample/tree/master/Sample) on GitHub.

## Installing the iOS SDK

You need to disable **Bitcode** in your Xcode target settings: 'Build Settings' -> 'Enable Bitcode' -> No

To enable **background mode**, go to your target settings -> 'Capabilities' -> 'Background Modes'  
- Turn on 'Audio, AirPlay and Picture in Picture'  
- Turn on 'Voice over IP'

Privacy permissions, in your plist add two new keys: 
- Privacy - Camera Usage Description
- Privacy - Microphone Usage Description

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ sudo gem install cocoapods --pre
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
        VoxeetSDK.sharedInstance.initializeSDK(consumerKey: "consumerKey", consumerSecret: "consumerSecret")

        return true
    }
    
    ...
}
```

## SDK Usage

### Initializing

```swift
VoxeetSDK.sharedInstance.initializeSDK(consumerKey: "consumerKey", consumerSecret: "consumerSecret")
```

If you use external login like O365, LDAP, or custom login to retrieve contact details it's now possible to also add your contact ID with the display name and the photo URL avatar.  
This allows you to ask guest users to introduce themselves and provide their display name and for your authenticated users in your enterprise or for your clients the ID that can be retrieved from O365 (name, department, etc).

```swift
VoxeetSDK.sharedInstance.initializeSDK(consumerKey: "consumerKey", consumerSecret: "consumerSecret", externalID: "ID", name: "name", avatarURL: "URL")
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

If you join a conference that does not exist, it will automatically create it. Basically you can use the join method instead of the create conference method above.

```swift
VoxeetSDK.sharedInstance.conference.join(conferenceID: confID) { (error) in
}
```

```swift
VoxeetSDK.sharedInstance.conference.join(conferenceAlias: confAlias) { (error) in
}
```

There is optional parameter too:
- parameter **video**: Starts own video by default.
- parameter **userInfo**: With this dictionary, you can pass additional information. For example if the user is only in "listener" mode you can add: ["participantType": "listener"].

```swift
VoxeetSDK.sharedInstance.conference.join(conferenceID: conferenceID, video: true, userInfo: ["participantType": "listener"]) { (error) in
}
```

### Leaving a conference

```swift
VoxeetSDK.sharedInstance.conference.leave { (error) in
}
```

### Sending broadcast message in a conference

```swift
VoxeetSDK.sharedInstance.conference.sendBroadcastMessage("message", completion: { (error) in
})
```

To receive the broadcast message, you can use the messageReceived from the VTConferenceDelegate (see below: `Available delegates / callbacks` section)

### Getting a specific conference status

```swift
VoxeetSDK.sharedInstance.conference.status(conferenceID: "", success: { (json) in
    }) { (error) in
}
```

### Subscribe to a conference to get its status within a notification
Notification's name: `ConferenceStatusUpdated`
```swift
init() {
    NotificationCenter.default.addObserver(self, selector: #selector(conferenceStatusUpdated), name: NSNotification.Name("ConferenceStatusUpdated"), object: nil)
}

func conferenceStatusUpdated(_ notification: Notification) {
    //
}
```

### Getting own user

```swift
let ownUser = VoxeetSDK.sharedInstance.conference.getOwnUser()
```

### Getting current conference users

```swift
let users = VoxeetSDK.sharedInstance.conference.getUsers()
```

### Getting a specific user's information

```swift
let infos = VoxeetSDK.sharedInstance.conference.getUserInfo("userID")
```

### Changing user position

```swift
// Values for angle and distance are between: angle = [-1, 1] and distance = [0, 1]
VoxeetSDK.sharedInstance.conference.setUserPosition(angle: 0, distance: 0, userID: "userID")
```

```swift
VoxeetSDK.sharedInstance.conference.setUserAngle(0, userID: "userID")
```

```swift
VoxeetSDK.sharedInstance.conference.setUserDistance(0, userID: "userID")
```

### Getting a specific user position

```swift
let (angle, distance) = VoxeetSDK.sharedInstance.conference.getUserPosition(userID: "userID")
```

### Muting / Unmuting a user

```swift
VoxeetSDK.sharedInstance.conference.muteUser(true, userID: "userID")
```

### Checking if a user is muted

```swift
let isMute = VoxeetSDK.sharedInstance.conference.isUserMuted(userID: "userID")
```

### Getting the participant's voice level

```swift
VoxeetSDK.sharedInstance.conference.getVoiceLevel(userID: "userID")
```

### Switching between BuiltInSpeaker and BuildInReceiver

```swift
VoxeetSDK.sharedInstance.conference.switchDeviceSpeaker()

// You can also force the BuiltInSpeaker / BuildInReceiver
VoxeetSDK.sharedInstance.conference.switchDeviceSpeaker(forceBuiltInSpeaker: true)
```

### Attaching a media stream to a renderer

```swift
VoxeetSDK.sharedInstance.conference.attachMediaStream(stream, renderer: videoRenderer)
```

### Unattaching a media stream to a renderer

```swift
VoxeetSDK.sharedInstance.conference.unattachMediaStream(stream, renderer: videoRenderer)
```

### Flipping the device camera (front/back)

```swift
VoxeetSDK.sharedInstance.conference.flipCamera()
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

    func sessionStateChanged(state: VTSessionState) {
    }
}
```
or
```swift
VoxeetSDK.sharedInstance.sessionStateChanged = { state in
}
```

### Conference

```swift
class myClass: VTConferenceDelegate {
    init() {
        // Conference delegate.
        VoxeetSDK.sharedInstance.conference.delegate = self
    }
    
    func participantAdded(userID: String, userInfo: [String: Any], stream: MediaStream) {
    }
    
    func participantUpdated(userID: String, userInfo: [String: Any], stream: MediaStream) {
    }
    
    func participantRemoved(userID: String, userInfo: [String: Any]) {
    }
    
    func messageReceived(userID: String, userInfo: [String: Any], message: String) {
    }
    
    func screenShareStarted(userID: String, stream: MediaStream) {
    }
    
    func screenShareStopped(userID: String) {
    }
}
```
or
```swift
VoxeetSDK.sharedInstance.conference.participantAdded = { (userID, userInfo, stream) in
}

VoxeetSDK.sharedInstance.conference.participantUpdated = { (userID, userInfo, stream) in
}

VoxeetSDK.sharedInstance.conference.participantRemoved = { (userID, userInfo) in
}

VoxeetSDK.sharedInstance.conference.messageReceived = { (userID, userInfo, message) in
}

VoxeetSDK.sharedInstance.conference.screenShareStarted = { (userID, stream) in
}

VoxeetSDK.sharedInstance.conference.screenShareStopped = { (userID) in
}
```

## Available enums

### Session state:

```swift
public enum VTSessionState {
    case notConnected
    case connected
    case connecting
    case reconnecting
}
```

### Error handler:

```swift
public enum VTErrorType: ErrorType {
    case credential(String)
    case internalServer
    case accessToken
    case noLiveConference
    case leaveConference
    case createConference
    case joinConference
    case sendBroadcastMessage
    case statusCode(Int?)
    case serverError(String?)
    case error(Error?)
}
```

### Notification handler:

Here is an example to handle the notification pushed by the Voxeet SDK (each time a notification is pushed, a log display the name of this one):

```bash
[DEBUG] Voxeet notification: \(NotificationName) (you can register to this notification to handle it)
```

```swift
init() {
    NotificationCenter.default.addObserver(self, selector: #selector(myFunc), name: NSNotification.Name("NotificationName"), object: nil)
}

func myFunc(notification: Notification) {
    // Get JSON.
    guard let userInfo = notification.userInfo?.values.first as? Data else {
        return
    }
    
    do {
        let json = try JSONSerialization.jsonObject(with: userInfo, options: .mutableContainers)
    } catch let error {
        //
    }
}
```

## VTAudioSound Usage

VTAudioSound helps you to play a TrueVoice 3D audio sound into your application.  
The sound must be encoded in **mono** to be played spatialized.

### Initializing

```swift
var sound: VTAudioSound?

if let path = Bundle.main.path(forResource: "myFile", ofType: "mp3") {
    do {
        sound = try VTAudioSound(url: URL(fileURLWithPath: path))
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

## Publish your app with the Voxeet SDK

The SDK is built to compile with the simulator **AND** generic iOS device.
Since november, Apple has stopped support "Fat libraries" like this one.
So when you want to publish your app, you will need to execute a script that delete the simulator support:

```bash
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
        echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
        lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
        EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
```

You can add this script in the `Build Phases` of your project.
Here is a tutorial if you want more details: http://ikennd.ac/blog/2015/02/stripping-unwanted-architectures-from-dynamic-libraries-in-xcode/

## Version

1.0.2.5.1

## Tech

The Voxeet iOS SDK uses a number of open source projects to work properly:

* [Starscream](https://github.com/daltoniam/Starscream) - Starscream is a conforming WebSocket (RFC 6455) client library in Swift for iOS and OSX.
* [Alamofire](https://github.com/Alamofire/Alamofire) - Alamofire is an HTTP networking library written in Swift.
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON makes it easy to deal with JSON data in Swift.
* [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) - Crypto related functions and helpers for Swift implemented in Swift.

© Voxeet, 2016