# Change Log

All notable changes to this project will be documented in this file.

#### 1.x Releases

- [1.4.8](#148)
- [1.4.7](#147)
- [1.4.6](#146)
- [1.4.5](#145)
- [1.4.4](#144)
- [1.4.3](#143)
- [1.4.2](#142)
- [1.4.1](#141)
- [1.4.0](#140)
- [1.3.9](#139)
- [1.3.8](#138)
- [1.3.7](#137)
- [1.3.6](#136)
- [1.3.5](#135)
- [1.3.4](#134)
- [1.3.3](#133)
- [1.3.2](#132)
- [1.3.1](#131)
- [1.3.0](#130)
- [1.2.9](#129)
- [1.2.8](#128)
- [1.2.7](#127)
- [1.2.6](#126)
- [1.2.5](#125)
- [1.2.4](#124)
- [1.2.3](#123)
- [1.2.2](#122)
- [1.2.1](#121)
- [1.2.0](#120)
- [1.1.2](#112)
- [1.1.1](#111)
- [1.1.0](#110)
- [1.0.9](#109)
- [1.0.8](#108)
- [1.0.7](#107)
- [1.0.6](#106)
- [1.0.5](#105)
- [1.0.4](#104)
- [1.0.3](#103)

---

## [1.4.8](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.8)

Released on 2019-11-04.

Convert for Swift 5.1.2.

## [1.4.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.7)

Released on 2019-10-04.

CXCallUpdate takes the default video value from the conference service to display if the call is video or audio.

## [1.4.6](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.6)

Released on 2019-10-04.

Fix iOS 13 crashes with stop video and screen share.

#### Added
- VoxeetSDK.shared.conference.audio3D

## [1.4.5](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.5)

Released on 2019-09-24.

Convert for Swift 5.1.

## [1.4.4](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.4)

Released on 2019-08-14.

Remove `conferenceType` from documentation.

## [1.4.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.3)

Released on 2019-08-09.

Save last user metadata for CallKit.

#### Updated
- VoxeetSDK.shared.initialize(consumerKey:consumerSecret:userInfo:connectSession:)
    - VoxeetSDK.shared.initialize(consumerKey:consumerSecret:)
- VoxeetSDK.shared.initialize(accessToken:userInfo:refreshTokenClosure:)
    - VoxeetSDK.shared.initialize(accessToken:refreshTokenClosure:)

## [1.4.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.2)

Released on 2019-08-07.

Patch Objective C simulator compilation due to a known issue from Xcode 10.2 (https://developer.apple.com/documentation/xcode_release_notes/xcode_10_2_release_notes).
Implement `isDefaultFrontFacing` to `startVideo` method.
Rename `flipCamera` to `switchCamera` to match with `switchDeviceSpeaker` and Android.

#### Updated
- VoxeetSDK.shared.conference.flipCamera(completion:)
    - VoxeetSDK.shared.conference.switchCamera(completion:)
    
#### Removed
- VoxeetSDK.shared.conference.audio3D

## [1.4.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.1)

Released on 2019-05-22.

Voice level getter bug fix.

## [1.4.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.0)

Released on 2019-05-20.

Remove 3D audio by default.
Conference decline bug fix for CallKit and standard notifications.

## [1.3.9](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.9)

Released on 2019-04-29.

Socket bug fix that can ring CallKit multiple times.

## [1.3.8](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.8)

Released on 2019-04-24.

Convert for Swift 5.0.1.

## [1.3.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.7)

Released on 2019-04-16.

Don't start a video capturer if the simulator is running.

## [1.3.6](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.6)

Released on 2019-04-15.

Stop camera if `startVideo` method failed.
Stop screen share if `startScreenShare` method failed.

## [1.3.5](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.5)

Released on 2019-04-12.

Implement standard push notification alongside CallKit.
Also add the possibility for a client to fully handle its own push notifications.
Expose publicly conference modes: standard, listen, replay.

#### Added

VoxeetSDK.shared.session.pushToken = *string*

#### Updated

- VoxeetSDK.shared.callKit = *bool*
    - VoxeetSDK.shared.pushNotification.type = *VTPushNotificationType*
- VoxeetSDK.shared.includesCallsInRecents = *bool*
    - VoxeetSDK.shared.pushNotification.includesCallsInRecents = *bool*
- VoxeetSDK.shared.incomingCallTimeout = *bool*
    - VoxeetSDK.shared.pushNotification.incomingCallTimeout = *bool*

## [1.3.4](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.4)

Released on 2019-03-28.

Convert for Swift 5.

## [1.3.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.3)

Released on 2019-03-22.

Fix a crash that can happen when joining / leaving a conference quickly.

## [1.3.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.2)

Released on 2019-03-20.

Patch expired access token after a long time.

## [1.3.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.1)

Released on 2019-03-15.

Patch memory leaks.

## [1.3.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.3.0)

Released on 2019-03-12.

Add conference encryption. Also add the ability for the client to manage their own PushKit instance.

#### Added

- VTConferenceCryptoDelegate *delegate*
- VTCallKitMuteToggled *notification*
- VoxeetSDK.shared.callKit(enable:initPushNotification:)

#### Updated

- RTCMediaStream *class*
    - MediaStream *class*

## [1.2.9](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.9)

Released on 2018-12-19.

Initialize with access token Objective-C compatibility.

## [1.2.8](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.8)

Released on 2018-12-04.

Implement i386 and x86_64 architectures.

## [1.2.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.7)

Released on 2018-11-23.

Keep the same socket identification after a disconnection.

## [1.2.6](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.6)

Released on 2018-11-13.

Hide Voxeet's bots.

## [1.2.5](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.5)

Released on 2018-10-31 (happy halloween! 🎃 👻).

Convert for Swift 4.2.1.

## [1.2.4](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.4)

Released on 2018-10-30.

Add a new `stats` method and notification.

#### Added

- VoxeetSDK.shared.conference.localStats(userID:)
- VTConferenceStats *notification*

#### Updated

- VoxeetSDK.shared.conference.getMediaStream(userID:)
    - VoxeetSDK.shared.conference.mediaStream(userID:)
- VoxeetSDK.shared.conference.getScreenShareMediaStream()
    - VoxeetSDK.shared.conference.screenShareMediaStream()

## [1.2.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.3)

Released on 2018-10-15.

Close CallKit when declining a call outside a conference.

## [1.2.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.2)

Released on 2018-10-12.

Re-enable video presentation.

#### Updated

- VTUser(id:name:photoURL:)
    - VTUser(externalID:name:avatarURL:)
- VoxeetSDK.shared.session.connect(userID:userInfo:completion:)
    - connect(user:completion:)
- VoxeetSDK.shared.conference.invite(conferenceID:ids:completion:)
    - invite(conferenceID:externalIDs:completion:)
- VTCallKitUpdated *notification*
    - VTCallKitSwapped *notification*

## [1.2.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.1)

Released on 2018-09-21.

Convert for Swift 4.2.

## [1.2.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.0)

Released on 2018-09-20.

Bitcode support.
Stop supporting simulator architecture.

## [1.1.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.2)

Released on 2018-07-10.

Convert for Swift 4.1.2.

## [1.1.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.1)

Released on 2018-04-03.

Convert for Swift 4.1.

## [1.1.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.0)

Released on 2018-03-27.

Swift 4.0.3 compatibility.

#### Added

- VoxeetSDK.shared.conference.subscribe(conferenceAlias:success:fail:)
- VoxeetSDK.shared.conference.unsubscribe(conferenceAlias:success:fail:)
- VoxeetSDK.shared.conference.statusUnsubscribe(conferenceID:completion:)
- VoxeetSDK.shared.blacklist(externalID:ban:completion:)
- VoxeetSDK.shared.callKit
- VoxeetSDK.shared.defaultVideo
- VoxeetSDK.shared.incomingCallTimeout

#### Updated

- VoxeetSDK.shared.conference.subscribe(conferenceID:completion:)
    - VoxeetSDK.shared.conference.statusSubscribe(conferenceID:completion:)
- VoxeetSDK.shared.conference.startRecording(conferenceID:completion:)
    - VoxeetSDK.shared.conference.startRecording(conferenceID:fireInterval:completion:)

## [1.0.9](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.9)

Released on 2017-11-15.

Remove ownUser from conference and replace it by the session user.
CallKit new optimizations and bug fixes.

#### Added

- VoxeetSDK.shared.conference.alias (custom conference identifier)

#### Updated

- VoxeetSDK.shared.conference.id _is now the internal Voxeet identifier for a live conference_.
- VoxeetSDK.shared.conference.liveConferenceID()
    - VoxeetSDK.shared.conference.id
- VoxeetSDK.shared.conference.ownUser
    - VoxeetSDK.shared.session.user

## [1.0.8](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.8)

Released on 2017-11-06.

Convert for Swift 4.0.2.

## [1.0.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.7)

Released on 2017-10-31.

VoxeetSDK is now fully compatible with Swift / Objective-C.

#### Added

- VoxeetSDK.shared.conference.toggleMute(userID:)

#### Updated

- CallKit isn't enabled by default anymore.
- VoxeetSDK.shared.initializeSDK(consumerKey:consumerSecret:userInfo:callKit:automaticallyOpenSession:)
    - VoxeetSDK.shared.initialize(consumerKey:consumerSecret:userInfo:callKit:connectSession:)
- VoxeetSDK.shared.connect(:)
    - VoxeetSDK.shared.session.connect(completion:)
- VoxeetSDK.shared.disconnect(:)
    - VoxeetSDK.shared.session.disconnect(completion:)
- VoxeetSDK.shared.openSession(userID:userInfo:completion:)
    - VoxeetSDK.shared.session.connect(userID:userInfo:completion:)
- VoxeetSDK.shared.closeSession(completion:)
    - VoxeetSDK.shared.session.disconnect(completion:)
- VoxeetSDK.shared.sessionState()
    - VoxeetSDK.shared.session.state
- VoxeetSDK.shared.sessionStateDelegate
    - VoxeetSDK.shared.session.delegate
- VoxeetSDK.shared.sessionStateChanged
    - VoxeetSDK.shared.session.updated
- VoxeetSDK.shared.enableCallKit
    - VoxeetSDK.shared.initialize(consumerKey:consumerSecret:userInfo:callKit:connectSession:)
- VoxeetSDK.shared.conference.createDemo(:)
    - VoxeetSDK.shared.conference.demo(completion:)
- VoxeetSDK.shared.conference.hasLiveConference()
    - VoxeetSDK.shared.conference.liveConferenceID()
- VoxeetSDK.shared.conference.getUsers()
    - VoxeetSDK.shared.conference.users
- VoxeetSDK.shared.conference.getOwnUser()
    - VoxeetSDK.shared.conference.ownUser
- VoxeetSDK.shared.conference.setUserPosition(angle:distance:userID:)
    - VoxeetSDK.shared.conference.userPosition(userID:angle:distance:)
- VoxeetSDK.shared.conference.setUserAngle(:userID:)
    - VoxeetSDK.shared.conference.userPosition(userID:angle:)
- VoxeetSDK.shared.conference.setUserDistance(:userID:)
    - VoxeetSDK.shared.conference.userPosition(userID:distance:)
- VoxeetSDK.shared.conference.muteUser(mute:userID:)
    - VoxeetSDK.shared.conference.mute(userID:isMuted:)
- VoxeetSDK.shared.conference.getVoiceLevel(userID:)
    - VoxeetSDK.shared.conference.voiceLevel(userID:)

#### Removed

- VoxeetSDK.shared.conference.getUserInfo(userID:)
- VoxeetSDK.shared.conference.getUserPosition(userID:)
- VoxeetSDK.shared.conference.isUserMuted(userID:)

## [1.0.6](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.6)

Released on 2017-09-19.

Convert for Swift 4.

## [1.0.5](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.5)

Released on 2017-07-04.

Also add 2 new conference methods: invite and decline (for CallKit).
Update create and join completion return value to have more information about the conference.

## [1.0.4](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.4)

Released on 2017-04-18.

Add 5 new endpoints: history, histories, start / stop recording, replay.

## [1.0.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.0.3)

Released on 2017-04-07.

Convert for Swift 3.1.
Change sharedInstance by shared like native iOS SDKs with swift >= 3 and update other methods names.
VoxeetSDK bug fixes and prepare to merge with CallKit (will be implemented in the next version).
