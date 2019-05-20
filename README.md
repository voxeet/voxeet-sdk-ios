# Voxeet iOS SDK

<p align="center">
<img src="https://www.voxeet.com/wp-content/themes/wp-theme/assets/images/logo.svg" alt="Voxeet SDK logo" title="Voxeet SDK logo" width="100"/>
</p>


## Requirements


* **Operating systems:** iOS 9.0 and later versions
* **IDE:** [Xcode 10.2+](https://developer.apple.com/xcode/)
* **Languages:** Swift 5+, Objective-C
* **Supported architectures:** armv7, arm64, i386, x86_64


## Sample Application
A sample application is available on this [GitHub repository](https://github.com/voxeet/voxeet-ios-sdk/tree/master/Sample).
You can also use a ready to go UI: **VoxeetConferenceKit** available at this link [https://github.com/voxeet/voxeet-ios-conferencekit](https://github.com/voxeet/voxeet-ios-conferencekit) (which embed this SDK).


## Installing the iOS SDK


### 1. Get your credentials
Get a consumer key and consumer secret for your app from [your developer account dashboard](https://developer.voxeet.com).

**If you are a new user, you'll need to sign up for a Voxeet developer account and add an app.** You can create one app with a trial account. Upgrade to a paid account for multiple apps and to continue using Voxeet after your trial expires. We will give you dedicated help to get you up and running fast.

### 2. Project setup
Enable **background mode** (go to your target settings -> 'Capabilities' -> 'Background Modes')
- Turn on 'Audio, AirPlay and Picture in Picture'  
- Turn on 'Voice over IP'

If you want to support CallKit (receiving incoming call when application is killed) with VoIP push notification, enable 'Push Notifications' (you will need to upload your [VoIP push certificate](https://developer.apple.com/account/ios/certificate/) to the Voxeet developer portal).

<p align="center">
<img src="http://cdn.voxeet.com/images/VoxeetConferenceKitCapabilitiesXCode2.png" alt="Capabilities" title="Capabilities" width="500"/>
</p>

Privacy **permissions**, add two new keys in the Info.plist: 
- Privacy - Microphone Usage Description
- Privacy - Camera Usage Description

### 3. Installation

#### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate [VoxeetSDK](https://github.com/voxeet/voxeet-ios-sdk) into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "voxeet/voxeet-ios-sdk" ~> 1.0
```

Run `carthage update` to build the frameworks and drag `VoxeetSDK.framework` and `WebRTC.framework` into your Xcode project. More information at [https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos).

### Manually
Download the lastest release zip:

**VoxeetSDK:** https://github.com/voxeet/voxeet-ios-sdk/releases

Unzip and drag and drop frameworks into your project, select 'Copy items if needed' with the right target. Then in the general tab of your target, add the `VoxeetConferenceKit.framework`, `VoxeetSDK.framework` and `WebRTC.framework` into **'Embedded Binaries'**.


## Initialize the Voxeet SDK
Two methods are currently available to initialize the SDK:
- Set the API keys in the app
- Use an OAuth2 server to provide the keys

### `initialize`
Initialize the SDK with your Voxeet user information.

#### Parameters
-   `consumerKey` **String** - The consumer key for your app from [your developer account dashboard](https://developer.voxeet.com).
-   `consumerSecret` **String** - The consumer secret for your app from [your developer account dashboard](https://developer.voxeet.com).
-   `userInfo` **[String: Any]?** - A dictionnary object that contains custom user information `["externalId": "1234", "externalName": "Username", "externalPhotoUrl": "https://voxeet.com/logo.jpg", ...]`.
-   `connectSession` **Bool?** - Connect session at a later time by setting this parameter to `false` and calling `VoxeetSDK.shared.session.connect(user:completion:)` when you want to connect. If `true` (by default), the SDK automatically connects the user at initialization (anonymously, if the `userInfo` parameter is empty).

#### Examples
```swift
import VoxeetSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Example of public variables to change the conference behavior.
        VoxeetSDK.shared.pushNotification.type = .none
        VoxeetSDK.shared.conference.defaultBuiltInSpeaker = false
        VoxeetSDK.shared.conference.defaultVideo = false
        VoxeetSDK.shared.conference.audio3D = true

        // Initialization of the Voxeet SDK.
        VoxeetSDK.shared.initialize(consumerKey: "YOUR_CONSUMER_KEY", consumerSecret: "YOUR_CONSUMER_SECRET")

        return true
    }
}
```

```swift
let userInfo = ["externalId": "1234", "externalName": "Username", "externalPhotoUrl": "http://voxeet.com/image.jpg"]

VoxeetSDK.shared.initialize(consumerKey: "YOUR_CONSUMER_KEY", consumerSecret: "YOUR_CONSUMER_SECRET", userInfo: userInfo, connectSession: true)
```


### `initialize` with Oauth2
Initialize the SDK with a valid token and a method to refresh it.

#### Parameters
-   `accessToken` **String** - A valid tokenAccess obtained from your own Oauth2 server.
-   `userInfo` **[String: Any]?** - A dictionnary object that contains custom user information `["externalId": "1234", "externalName": "Username", "externalPhotoUrl": "https://voxeet.com/logo.jpg", ...]`.
-   `refreshTokenClosure` **@escaping ((_ closure: @escaping (_ token: String) -> Void) -> Void)** - This closure will be called when the access token needs to be refreshed from your server. Inside this one, refresh your access token and use the closure parameter to notify Voxeet of the changement: `closure("token")`.

#### Example
```swift
VoxeetSDK.shared.initialize(accessToken: "YOUR_TOKEN", userInfo: nil, refreshTokenClosure: { closure in
    yourRefreshTokenMethod() { token in
        closure(token)
    }
})
```


### `callKit`
Display the system-calling UI for your app's VoIP services.

[CallKit](https://developer.apple.com/documentation/callkit) is disabled by default. 'Push Notifications' capability needs to be enabled.

Some [events](#Events) can be used along with `callKit` to update the UI, such as `VTCallKitStarted`, `VTCallKitSwapped`, `VTCallKitEnded`, `VTCallKitMuteToggled`.

#### Example

```swift
VoxeetSDK.shared.pushNotification.type = .callKit
VoxeetSDK.shared.initialize(consumerKey: "YOUR_CONSUMER_KEY", consumerSecret: "YOUR_CONSUMER_SECRET")

/*
 *  MARK: - Voxeet VoIP push notifications
 *  To handle VoIP push notifications before iOS 10, you must use this AppDelegate extension:
 */

extension AppDelegate {
    /// Useful below iOS 10.
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        VoxeetSDK.shared.pushNotification.application(application, didReceive: notification)
    }
    
    /// Useful below iOS 10.
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        VoxeetSDK.shared.pushNotification.application(application, handleActionWithIdentifier: identifier, for: notification, completionHandler: completionHandler)
    }
}
```


## Session


### `user`
Get current session's user (`VTUser`).

#### Example
```swift
let user = VoxeetSDK.shared.session.user
```

### `state`
Get current session's state. 
`VTSessionState` enum: `connecting`, `connected`, `reconnecting` or `disconnected`.

#### Examples
```swift
let state = VoxeetSDK.shared.session.state
```

A delegate is also available to observe session updates:

```swift
class myClass: VTSessionDelegate {
    init() {
        VoxeetSDK.shared.session.delegate = self
    }

    func sessionUpdated(state: VTSessionState) {
    }
}
```


### `connect`
*This method is optional.*
Connect a session is like a login, however the SDK needs to be initialized with `connectSession` sets to `false`. This method can be useful if CallKit is implemented (VoIP push notifications) because once the session is openned, notifications can be received if there is an invitation.

#### Parameters
-   `user` **VTUser?** - A user to be linked to our server.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether or not the connection to the server succeeded.

#### Example
```swift
let user = VTUser(externalID: "1234", name: "Username", avatarURL: "https://voxeet.com/logo.jpg")
VoxeetSDK.shared.session.connect(user: user) { error in
}
```


### `disconnect`
*This method is optional.*
Close a session is like a logout, it will stop the socket and stop sending VoIP push notification.

#### Parameter
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether or not the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.session.disconnect { error in
}
```


## Conferences


### `id`
Get the live conference ID (Voxeet internal identifier). If `nil` there is no conference going on.

#### Example
```swift
let conferenceID = VoxeetSDK.shared.conference.id
```

### `alias`
Get the live conference alias. If `nil` there is no conference going on.

#### Example
```swift
let conferenceAlias = VoxeetSDK.shared.conference.alias
```

### `users`
Get current conference users (`[VTUser]`).

#### Examples
```swift
let users = VoxeetSDK.shared.conference.users
```

A user can have many status before and after being connected to a conference (see `VTUserConferenceStatus` enum).
To only get users of the live conference:

```swift
let liveUsers = VoxeetSDK.shared.conference.users.filter({ $0.asStream })
```


### `create`
Create a conference. You can call `join` method if creation succeeds.

#### Parameters
-   `parameters` **[String: Any]?** - Option for passing some parameters when you create a conference, such as `conferenceAlias` (e.g., `["conferenceAlias": "myCustomConferenceAlias", "conferenceType": "standard", "metadata": ["stats": false, "liveRecording": false], "params": ["videoCodec": "VP8"/"H264"]]`). Those parameters are specific to a conference and should not be confused with `userInfo`.
-   `success` **((_ json: [String: Any]?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a `[String: Any]` argument that corresponds to a JSON dictionary object.
-   `fail` **((_ error: NSError) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Examples
```swift
VoxeetSDK.shared.conference.create(success: { json in
    guard let confID = json?["conferenceId"] as? String,
          let confAlias = json?["conferenceAlias"] as? String else {
        return
    }
}, fail: { error in
})
```

```swift
VoxeetSDK.shared.conference.create(parameters: ["conferenceAlias": "myCustomConferenceAlias", "conferenceType": "standard", "metadata": ...], success: { json in
}, fail: { error in
})
```


### `join`
Join the created conference.

#### Parameters
-   `conferenceID` **String** - Conference identifier retrieved from `create` response (also compatible with conference alias).
-   `video` **Bool?** - Starts own video when launching the conference (false by default).
-   `userInfo` **[String: Any]?** - Dictionary you can use to pass additional information linked to the user. For example if the user is only in "listener" mode you can add: `["participantType": "listener"]`. You can also add any data you want to set for a user: `["externalId": "1234", "externalName": "Username", "externalPhotoUrl": "https://voxeet.com/logo.jpg", ...]` (if the SDK's session isn't connected yet).
-   `success` **((_ json: [String: Any]?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a `[String: Any]` argument that corresponds to a JSON dictionary object.
-   `fail` **((_ error: NSError) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Examples
```swift
VoxeetSDK.shared.conference.create(success: { json in
    guard let conferenceID = json?["conferenceId"] as? String else { return }
    
    VoxeetSDK.shared.conference.join(conferenceID: conferenceID, success: { json in
    }, fail: { error in
    })
    
}, fail: { error in
})
```

```swift
VoxeetSDK.shared.conference.join(conferenceID: conferenceID, video: true, userInfo: ["participantType": "listener"], success: { json in
}, fail: { error in
})
```


### `leave`
Leave the current conference.

#### Parameter
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.leave { error in
}
```


### `status`
Retrieve the status of specified conference.

#### Parameters
-   `conferenceID` **String** - The ID of the conference whose status you want to retrieve.
-   `success` **((_ json: [String: Any]?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `[String: Any]?` argument that corresponds to a JSON object.
-   `fail` **((_ error: NSError) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.status(conferenceID: conferenceID, success: { json in
}, fail: { error in
})
```


### `statusSubscribe`
Subscribe to all status updates for a specified conference, such as added / removed participants and conference ended, within a [notification](#Events) and **without joinning the conference**.

**The conference must be created before using this method**

#### Parameters
-   `conferenceID` **String** - The ID of the conference whose status updates you want to subscribe to (also compatible with conference alias).
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
init() {
    NotificationCenter.default.addObserver(self, selector: #selector(conferenceStatusUpdated), name: .VTConferenceStatusUpdated, object: nil)

    VoxeetSDK.shared.conference.statusSubscribe(conferenceID: conferenceID, completion: { error in
    })
}

@objc func conferenceStatusUpdated(_ notification: Notification) {
}
```


### `statusUnsubscribe`
Unsubscribe from status updates [notifications](#Events) for the specified conference.

#### Parameters
-   `conferenceID` **String** - The ID of the conference whose status events you want to unsubscribe from (also compatible with conference alias).
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.statusUnsubscribe(conferenceID: conferenceID, completion: { error in
})
```


### `localStats`
Get local WebRTC stats.

#### Parameter
-   `userID` **String** - The ID of the user whose local WebRTC stats you want to retrieve.

#### Returns
-   **[[String: Any]]?** - An array that contains all information in a `Dictionary`.

#### Example
```swift
let stats = VoxeetSDK.shared.conference.localStats(userID: "userID")
```


## Record conferences


### `startRecording`
Record a conference so you can replay it after it ends.

#### Parameters
-   `fireInterval` **Int?** - Useful when replaying a conference with an offset (in milliseconds). Allows the video stream to be more or less reactive depending on the length of the record. By default at 10000 milliseconds.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.startRecording(completion: { error in
})
```


### `stopRecording`
Stop the current recording (a recording needs to be started before with `startRecording` method).

#### Parameter
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.stopRecording(completion: { error in
})
```


## Replay conferences


### `replay`
Replay a recorded conference.

#### Parameters
-   `conferenceID` **String** - The ID of the conference you want to replay. Do not pass a conference alias --- pass only an ID, such as the Voxeet conference UUID returned by the `join` method.
-   `offset` **Int?** - The recording offset from the beginning of the conference. In milliseconds (default `0`).
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Examples
```swift
VoxeetSDK.shared.conference.replay(conferenceID: conferenceID, completion: { error in
})
```

```swift
// Replay a conference without the first second.
VoxeetSDK.shared.conference.replay(conferenceID: conferenceID, offset: 1000, completion: { error in
})
```


## Audio and video devices


### `switchDeviceSpeaker`
Switch between BuiltInSpeaker and BuiltInReceiver.

#### Parameter
-   `forceBuiltInSpeaker` **Bool?** - If `true`, forces the audio to set on the main speaker. If `false`, forces the builtInReceiver.

#### Examples
```swift
VoxeetSDK.shared.conference.switchDeviceSpeaker()
```

```swift
VoxeetSDK.shared.conference.switchDeviceSpeaker(forceBuiltInSpeaker: true)
```


### `flipCamera`
Change the device camera (front or back).

#### Example
```swift
VoxeetSDK.shared.conference.flipCamera()
```


### `mediaStream`
Get the current stream of a user.

#### Parameter
-   `userID` **String** - User ID.

#### Returns
-   **MediaStream?** - The stream to be rendered into the view.

#### Example
```swift
let stream = VoxeetSDK.shared.conference.mediaStream(userID: "userID")
```


### `screenShareMediaStream`
Get the current screen share stream.

#### Returns
-   **MediaStream?** - The stream to be rendered into the view.

#### Example
```swift
let stream = VoxeetSDK.shared.conference.screenShareMediaStream()
```


### `attachMediaStream`
Attach a media stream to a renderer. You can create a renderer with a UIView that inherits from `VTVideoView`.

#### Parameters
-   `stream` **MediaStream** - The stream to be rendered into the view.
-   `renderer` **RTCVideoRenderer** - The view renderer that will display the video.

#### Example
```swift
let stream = VoxeetSDK.shared.conference.mediaStream(userID: "userID")
let videoRenderer = VTVideoView()
VoxeetSDK.shared.conference.attachMediaStream(stream, renderer: videoRenderer)
```


### `unattachMediaStream`
Unattach a media stream from a renderer. If you remove the video renderer from the UI, you do not need to call this method.

This method is useful for switching among several streams with the same video renderer.

#### Parameters
-   `stream` **MediaStream** - The stream to be rendered into the view.
-   `renderer` **RTCVideoRenderer** - The view renderer that will display the video.

#### Example
```swift
let stream = VoxeetSDK.shared.conference.mediaStream(userID: "userID")
let videoRenderer = VTVideoView()
VoxeetSDK.shared.conference.unattachMediaStream(stream, renderer: videoRenderer)
```


### `startVideo`
Start the video for the specified user (typically, your own user ID). However you can't force starting or stopping a video from a specific user other than you.

#### Parameters
-   `userID` **String** - The ID for the user whose video you want to start.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
let ownUserID = VoxeetSDK.shared.session.user!.id!
VoxeetSDK.shared.conference.startVideo(userID: ownUserID, completion: { error in
})
```


### `stopVideo`
Stop video for the specified user.

#### Parameters
-   `userID` **String** - The ID for the user whose video you want to stop.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.stopVideo(userID: ownUserID, completion: { error in
})
```


## Manage users


### `invite`
Invite users to a conference. Users will receive an [invitationReceived](#Events) event.

If `callKit` and push notifications are **enabled**, the invitation will ring on invited users' devices with the Apple incoming call user interface.

#### Parameters
-   `conferenceID` **string** - The ID of the conference you want to invite users to.
-   `externalIDs` **[String]** - An array of external IDs for users to invite.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.invite(conferenceID: conferenceID, externalIDs: ["userID", ...], completion: { error in
})
```


### `userPosition`
Set user position for the spatialized audio mode.

#### Parameters
-   `userID` **String** - The ID for the user whose position you want to set.
-   `angle` **Double** - The user's X position. Must be a value between `-1.0` and `1.0`.
-   `distance` **Double** - The user's Y position. Must be a value between `0.0` and `1.0`.

#### Example
```swift
VoxeetSDK.shared.conference.userPosition(userID: "userID", angle: 0, distance: 0)
```


### `mute`
Mute or unmute the specified user.

#### Parameters
-   `userID` **String** - The ID of the user you want to mute.
-   `isMuted` **Bool** - `true` if user is muted. Otherwise, `false`.

#### Example
```swift
VoxeetSDK.shared.conference.mute(userID: "userID", isMuted: true)
```


### `toggleMute`
Toggle mute for the specified user.

#### Parameters
-   `userID` **string** - The ID of the user you want to mute or unmute.

#### Returns
`Bool` - The state of mute for the user.

#### Example
```swift
let isMuted = VoxeetSDK.shared.conference.toggleMute(userID: "userID")
```


### `voiceLevel`
Retrieve the specified user's current audio level, normalized between `0.0` and `1.0`.

#### Parameter
-   `userID` **String** - The ID of the user whose level you want to retrieve.

#### Returns
`Double` - The user's current voice level, between `0.0` and `1.0`.

#### Example
```swift
let voiceLevel = VoxeetSDK.shared.conference.voiceLevel(userID: "userID")
```


## Broadcast messages


### `broadcast`
Broadcast messages as raw strings of any type (including JSON, XML, simple string) to all conference participants.

To receive a broadcast message, use the `messageReceived` method from the [VTConferenceDelegate](#Events) event.

#### Parameters
-   `message` **String** - The message to broadcast as a raw string.
-   `completion` **((_ error: NSError?) -> Void)?** - A block object to be executed when the server connection sequence ends. This block has no return value and takes a single `NSError` argument that indicates whether the connection to the server succeeded.

#### Example
```swift
VoxeetSDK.shared.conference.broadcast(message: "message", completion: { error in
})
```


## Events


### Delegates

#### `VTSessionDelegate`
`VTSessionState` enum: `connecting`, `connected`, `reconnecting` or `disconnected`.

```swift
class myClass: VTSessionDelegate {
    init() {
        VoxeetSDK.shared.session.delegate = self
    }

    func sessionUpdated(state: VTSessionState) {}
}
```

#### `VTConferenceDelegate`
```swift
class myClass: VTConferenceDelegate {
    init() {
        VoxeetSDK.shared.conference.delegate = self
    }

    func participantJoined(userID: String, stream: MediaStream) {}
    func participantUpdated(userID: String, stream: MediaStream) {}
    func participantLeft(userID: String) {}
    func messageReceived(userID: String, message: String) {}
    func screenShareStarted(userID: String, stream: MediaStream) {}
    func screenShareStopped(userID: String) {}
}
```

#### `VTConferenceCryptoDelegate`
```swift
class myClass: VTConferenceCryptoDelegate {
    init() {
        VoxeetSDK.shared.conference.cryptoDelegate = self
    }
    
    func encrypt(type: Int, ssrc: Int, frame: UnsafePointer<UInt8>, frameSize: Int, encryptedFrame: UnsafeMutablePointer<UInt8>, encryptedFrameSize: Int) {}
    func getMaxCiphertextByteSize(type: Int, size: Int) {}
    func decrypt(type: Int, ssrc: Int, encryptedFrame: UnsafePointer<UInt8>, encryptedFrameSize: Int, frame: UnsafeMutablePointer<UInt8>, frameSize: Int) {}
    func getMaxPlaintextByteSize(type: Int, size: Int) {}
}
```


### Handling notifications
Here is an example of how to handle notifications pushed by the Voxeet SDK.

```swift
init() {
    NotificationCenter.default.addObserver(self, selector: #selector(conferenceDestroyedPush), name: .VTConferenceDestroyedPush, object: nil)
}

@objc func conferenceDestroyedPush(notification: Notification) {
    guard let userInfo = notification.userInfo?.values.first as? Data else { return }
    let json = try? JSONSerialization.jsonObject(with: userInfo, options: .mutableContainers)
}
```

```swift
extension Notification.Name {
    public static let VTOfferCreated = Notification.Name("OfferCreated")
    public static let VTParticipantAdded = Notification.Name("ParticipantAdded")
    public static let VTParticipantUpdated = Notification.Name("ParticipantUpdated")
    public static let VTParticipantSwitched = Notification.Name("ParticipantSwitched")
    
    public static let VTOwnConferenceCreatedEvent = Notification.Name("OwnConferenceCreatedEvent")
    public static let VTConferenceStatusUpdated = Notification.Name("ConferenceStatusUpdated")
    public static let VTConferenceDestroyedPush = Notification.Name("ConferenceDestroyedPush")
    public static let VTConferenceMessageReceived = Notification.Name("ConferenceMessageReceived")
    public static let VTOwnParticipantSwitched = Notification.Name("OwnParticipantSwitched")
    public static let VTQualityIndicators = Notification.Name("QualityIndicators")
    
    public static let VTOwnUserInvitedEvent = Notification.Name("OwnUserInvitedEvent")
    public static let VTInvitationReceivedEvent = Notification.Name("InvitationReceivedEvent")
    
    public static let VTFileSharedEvent = Notification.Name("FileSharedEvent")
    public static let VTFileConvertedEvent = Notification.Name("FileConvertedEvent")
    public static let VTFilePresentationStarted = Notification.Name("FilePresentationStarted")
    public static let VTFilePresentationUpdated = Notification.Name("FilePresentationUpdated")
    public static let VTFilePresentationStopped = Notification.Name("FilePresentationStopped")
    
    public static let VTVideoPresentationStarted = Notification.Name("VideoPresentationStarted")
    public static let VTVideoPresentationStopped = Notification.Name("VideoPresentationStopped")
    public static let VTVideoPresentationPlay = Notification.Name("VideoPresentationPlay")
    public static let VTVideoPresentationPause = Notification.Name("VideoPresentationPause")
    public static let VTVideoPresentationSeek = Notification.Name("VideoPresentationSeek")
    
    public static let VTCallKitStarted = Notification.Name("VTCallKitStarted")
    public static let VTCallKitSwapped = Notification.Name("VTCallKitSwapped")
    public static let VTCallKitEnded = Notification.Name("VTCallKitEnded")
    public static let VTCallKitMuteToggled = Notification.Name("VTCallKitMuteToggled")
}
```

## Tech

The Voxeet iOS SDK and ConferenceKit rely on these open source projects:

* [Starscream](https://github.com/daltoniam/Starscream), a conforming WebSocket (RFC 6455) client library in Swift for iOS and OSX.
* [Alamofire](https://github.com/Alamofire/Alamofire), an HTTP networking library written in Swift.
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON), a tool for handling JSON data in Swift.

## SDK version

1.4.0

© Voxeet, 2019
