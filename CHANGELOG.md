# Change Log

All notable changes to this project will be documented in this file.

#### v3.x Releases

- [v3.3.0](#v330)
- [v3.2.2](#v322)
- [v3.2.1](#v321)
- [v3.2.0](#v320)
- [v3.1.7](#v317)
- [v3.1.6](#v316)
- [v3.1.5](#v315)
- [v3.1.4](#v314)
- [v3.1.3](#v313)
- [v3.1.2](#v312)
- [v3.1.1](#v311)
- [v3.1.0](#v310)
- [v3.0.3](#v303)
- [v3.0.2](#v302)
- [v3.0.1](#v301)
- [v3.0.0](#v300)

#### v2.x Releases

- [v2.4.1](#v241)
- [v2.4.0](#v240)
- [v2.3.1](#v231)
- [v2.3.0](#v230)
- [v2.2.1](#v221)
- [v2.2.0](#v220)
- [v2.1.1](#v211)
- [v2.1.0](#v210)
- [v2.0.0](#v200)

#### v1.x Releases

- [1.4.9](#149)
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

## [v3.3.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.3.0-beta.3)

Released on 2021-10-07.

### Features
- Added in VTConferenceParameters a new audioOnly parameter that allows creating audio-only conferences where participants cannot enable cameras.
- Added in VTSessionService a new isOpen method that checks whether there is an open session that connects SDK with backend.

### Bug Fixes
- Modified the VTParticipantPermissions.permissions and VTConference.permissions parameters. These parameters are now compatible with Objective-C.

## [v3.2.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.2.2)

Released on 2021-09-15.

- Added support for Xcode 13 and Swift 5.5.

## [v3.2.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.2.1)

Released on 2021-08-26.

### Bug Fixes
- Fixed an issue with audio and video synchronization.
- Fixed an issue with reporting Dolby Voice errors to the SDK.

## [v3.2.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.2.0)

Released on 2021-07-08.

### Features
- Modified the startAudio and stopAudio APIs to allow muting remote participants in Dolby Voice conferences.
- Introduced the setComfortNoiseLevel and getComfortNoiseLevel methods to allow checking the comfort noise level and setting the level to the desired value.
- Added the audioTransmitting and audioReceivingFrom properties to the VTParticipant model. The audioTransmitting property informs whether the participant transmits audio to the backend. The audioReceivingFrom property informs whether the participant receives audio from the asked participant.

### Bug Fixes
- Fixed an issue where moving objects are displayed with poor video quality.

## [v3.1.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.7)

Released on 2021-06-29.

### Features
Added the WebRTC dSYM debugging information file that allows formatting crash reports to improve their readability.

### Bug Fixes
- Fixed an issue where iOS users join a conference with disabled microphones that cannot be enabled and, after a short time, the users are kicked out of the conference.
- Fixed an issue where a conference freezes for three seconds after using the leave method. After the fix, the conference may still freeze, but the freeze does not last for more than one second.

## [v3.1.6](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.6)

Released on 2021-05-19.

- Fixed an issue where the completion handler is not called after using the muteOutput method.
- Modified data filtering to improve telemetry statistics.

## [v3.1.5](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.5)

Released on 2021-04-27.

- Added support for Xcode 12.5 and Swift 5.4.

## [v3.1.4](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.4)

Released on 2021-04-14.

- Fixed an issue where a conference participant who tries to join a conference as a listener, joins a conference as a user who can broadcast media.

## [v3.1.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.3)

Released on 2021-04-05.

- Added the possibility to subscribe to the streamAdded, streamUpdated, and streamRemoved events using the Apple NotificationCenter.

## [v3.1.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.2)

Released on 2021-03-25.

- Fixed an issue where the Xcode `po` debug command returns an error.
- Fixed an issue with black frames visible for the local participant during a screen-share session.

## [v3.1.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.1)

Released on 2021-03-09.

- Fixed an issue with the startVideo and stopVideo methods that did not work properly in the listener mode.
- Fixed the maxVideoForwarding accessor to make it compatible with Objective-C.

## [v3.1.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.1.0)

Released on 2021-03-01.

### Features
- Introduced the Video Forwarding feature to allow participants to dynamically control the number of transmitted video streams. The Video Forwarding article describes in detail the changes to Interactivity APIs.
- Introduced updates to the client SDK to support the use of conference access tokens for limiting the scope of participant permissions. The Enhanced Conference Access Control article describes in detail the changes to Interactivity APIs.

## [v3.0.3](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.0.3)

Released on 2020-12-15.

Convert for Swift 5.3.2.

## [v3.0.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.0.2)

Released on 2020-11-30.

Fix local audio level and video renderer mirror effect.

## [v3.0.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.0.1)

Released on 2020-11-16.

Convert for Swift 5.3.1 and fix CallKit joining issues.

## [v3.0.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v3.0.0)

Released on 2020-10-29.

Dolby Voice integration.

#### Updated
- IPHONEOS_DEPLOYMENT_TARGET = 9.0 (old)
    - IPHONEOS_DEPLOYMENT_TARGET = 11.0 (new)
- ENABLE_BITCODE = YES
    - ENABLE_BITCODE = NO

## [v2.4.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.4.1)

Released on 2020-09-17.

Convert for Swift 5.3 and Xcode 12 compatibility (support for the simulator & CocoaPods has been temporarily removed).

## [v2.4.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.4.0)

Released on 2020-06-22.

Send some exceptions to the server in order to be visible in the developer portal.

#### Added
- VoxeetSDK.shared.conference.isSpeaking(participant:)

## [v2.3.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.3.1)

Released on 2020-05-25.

Convert for Swift 5.2.4.

## [v2.3.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.3.0)

Released on 2020-05-12.

Implement new screen share broadcasting feature.
Improve CallKit behaviour when ending a call.
Telemetry crash fixed.

#### Added
- VTJoinOptionsConstraints.audio = *Bool*
- VoxeetSDK.shared.conference.startAudio(participant:completion)
- VoxeetSDK.shared.conference.stopAudio(participant:completion)

#### Updated
- VoxeetSDK.shared.conference.startScreenShare(completion:) (old)
    - VoxeetSDK.shared.conference.startScreenShare(broadcast:completion:) (new)
- VoxeetSDK.shared.conference.mute(participant:isMuted)
    - VoxeetSDK.shared.conference.mute(isMuted)

## [v2.2.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.2.1)

Released on 2020-04-17.

Convert for Swift 5.2.2.

## [v2.2.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.2.0)

Released on 2020-03-30.

Add new subsribe/unsubscribe methods.
Also update Carthage source location from:
binary "https://voxeet-cdn.s3.amazonaws.com/sdk/ios/release/VoxeetSDK.json"
to:
binary "https://raw.githubusercontent.com/voxeet/voxeet-sdk-ios/master/VoxeetSDK.json"

#### Added
- VTNotificationDelegate *protocol*
- VTInvitationReceivedNotification *class*
- VTConferenceStatusNotification *class*
- VTConferenceCreatedNotification *class*
- VTConferenceEndedNotification *class*
- VTParticipantJoinedNotification *class*
- VTParticipantLeftNotification *class*
- VTSubscribeConferenceCreated *class*
- VTSubscribeConferenceEnded *class*
- VTSubscribeParticipantJoined *class*
- VTSubscribeParticipantLeft *class*
- VoxeetSDK.shared.notification.push = *VTNotificationPushManager*
- VoxeetSDK.shared.notification.subscribe(subscriptions:completion:)
- VoxeetSDK.shared.notification.unsubscribe(subscriptions:completion:)

#### Updated
- VoxeetSDK.shared.notification.type (old)
    - VoxeetSDK.shared.notification.push.type (new)
- VoxeetSDK.shared.notification.includesCallsInRecents
    - VoxeetSDK.shared.notification.push.includesCallsInRecents
- VoxeetSDK.shared.notification.incomingCallTimeout
    - VoxeetSDK.shared.notification.push.incomingCallTimeout
- VoxeetSDK.shared.notification.application(didReceive:)
    - VoxeetSDK.shared.notification.push.application(didReceive:)
- VoxeetSDK.shared.notification.application(handleActionWithIdentifier:notification:completionHandler:)
    - VoxeetSDK.shared.notification.push.application(handleActionWithIdentifier:notification:completionHandler:)

## [v2.1.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.1.1)

Released on 2020-03-25.

Convert for Swift 5.2.

## [v2.1.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.1.0)

Released on 2020-03-02.

Add telemetry service and resolve video renderer crash.

#### Updated
- VoxeetSDK.shared.conference.invite(conferenceID:externalIDs:completion:) (old)
    - VoxeetSDK.shared.notification.invite(conference:participantInfos:completion:) (new)

## [v2.0.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/v2.0.0)

Released on 2019-12-16.

Better segmentation of functionalities across a service based architecture and better robustness in conference.

#### Added
- VTConference *class*
- VTConferenceStatus *enum*
- VTConferenceOptions *class*
- VTConferenceParameters *class*
- VTJoinOptions *class*
- VTJoinOptionsConstraints *class*
- VoxeetSDK.shared.conference.current = *VTConference*
- participantAdded(participant:) *VTConferenceDelegate*
- participantUpdated(participant:) *VTConferenceDelegate*
- statusUpdated(status:) *VTConferenceDelegate*
- streamAdded(participant:stream:) *VTConferenceDelegate*
- streamUpdated(participant:stream:) *VTConferenceDelegate*
- streamRemoved(participant:stream:) *VTConferenceDelegate*
- VTCommandDelegate *protocol*
- received(participant:message:) *VTCommandDelegate*
- VTFilePresentation *class*
- VTFileConverted *class*
- VTFilePresentationDelegate *protocol*
- converted(fileConverted:) *VTFilePresentationDelegate*
- started(filePresentation:) *VTFilePresentationDelegate*
- updated(filePresentation:) *VTFilePresentationDelegate*
- stopped(filePresentation:) *VTFilePresentationDelegate*
- VTVideoPresentation *class*
- VTVideoPresentationState *enum*
- VTVideoPresentationDelegate *protocol*
- started(videoPresentation:) *VTVideoPresentationDelegate*
- stopped(videoPresentation:) *VTVideoPresentationDelegate*
- played(videoPresentation:) *VTVideoPresentationDelegate*
- paused(videoPresentation:) *VTVideoPresentationDelegate*
- sought(videoPresentation:) *VTVideoPresentationDelegate*
- VTParticipantInfo *class*
- VTParticipantStatus *enum*

#### Updated
- VoxeetSDK.shared.session.participant (old)
    - VoxeetSDK.shared.session.user (new)
- VoxeetSDK.shared.conference.state
    - VoxeetSDK.shared.conference.current.status
- VoxeetSDK.shared.conference.id
    - VoxeetSDK.shared.conference.current.id
- VoxeetSDK.shared.conference.alias
    - VoxeetSDK.shared.conference.current.alias
- VoxeetSDK.shared.conference.users
    - VoxeetSDK.shared.conference.current.participants
- VoxeetSDK.shared.conference.isDefaultFrontFacing
    - VoxeetSDK.shared.mediaDevice.isDefaultFrontFacing
- VoxeetSDK.shared.conference.isFrontCamera
    - VoxeetSDK.shared.mediaDevice.isFrontCamera
- VoxeetSDK.shared.conference.create(parameters:success:fail)
    - VoxeetSDK.shared.conference.create(options:success:fail:)
- VoxeetSDK.shared.conference.join(conferenceID:video:userInfo:success:fail:)
    - VoxeetSDK.shared.conference.join(conference:options:success:fail:)
- VoxeetSDK.shared.conference.startRecording(fireInterval:completion:)
    - VoxeetSDK.shared.recording.start(fireInterval:completion:)
- VoxeetSDK.shared.conference.stopRecording(completion:)
    - VoxeetSDK.shared.recording.stop(completion:)
- VoxeetSDK.shared.conference.broadcast(message:completion:)
    - VoxeetSDK.shared.command.send(message:completion:)
- VoxeetSDK.shared.conference.mediaStream(userID:)
    - VoxeetSDK.shared.mediaDevice.mediaStream(userID:)
- VoxeetSDK.shared.conference.screenShareMediaStream()
    - VoxeetSDK.shared.mediaDevice.screenShareMediaStream()
- VoxeetSDK.shared.conference.attachMediaStream(stream:renderer:)
    - VoxeetSDK.shared.mediaDevice.attachMediaStream(stream:renderer:)
- VoxeetSDK.shared.conference.unattachMediaStream(stream:renderer:)
    - VoxeetSDK.shared.mediaDevice.unattachMediaStream(stream:renderer:)
- VoxeetSDK.shared.conference.switchDeviceSpeaker()
    - VoxeetSDK.shared.mediaDevice.switchDeviceSpeaker()
- VoxeetSDK.shared.conference.switchDeviceSpeaker(forceBuiltInSpeaker:completion:)
    - VoxeetSDK.shared.mediaDevice.switchDeviceSpeaker(forceBuiltInSpeaker:completion:)
- VoxeetSDK.shared.conference.switchCamera()
    - VoxeetSDK.shared.mediaDevice.switchCamera()
- messageReceived(userID:message:) *VTConferenceDelegate*
    - received(participant:message:) *VTCommandDelegate*
- participantJoined(userID:stream:) *VTConferenceDelegate*
    - streamAdded(participant:stream:) *VTConferenceDelegate*
- participantUpdated(userID:stream:) *VTConferenceDelegate*
    - streamUpdated(participant:stream:) *VTConferenceDelegate*
- participantLeft(userID:) *VTConferenceDelegate*
    - streamRemoved(participant:stream:) *VTConferenceDelegate*
- screenShareStarted(userID:stream:) *VTConferenceDelegate*
    - streamAdded(participant:stream:) *VTConferenceDelegate*
- screenShareStopped(userID:) *VTConferenceDelegate*
    - streamRemoved(participant:stream:) *VTConferenceDelegate*
- VTUser *class*
    - VTParticipant *class*
- VTUser.externalID *String*
    - VTParticipant.info = *VTParticipantInfo*
- VTUser.name *String*
    - VTParticipant.info = *VTParticipantInfo*
- VTUser.avatarURL *String*
    - VTParticipant.info = *VTParticipantInfo*
- VTUser.hasStream *Bool*
    - VTParticipant.streams = *[MediaStream]*

#### Removed
- VTConferenceState *enum*
- VoxeetSDK.shared.conference.user(userID:)
- VTUser.metadata = *[String: Any]*

## [1.4.9](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.9)

Released on 2019-12-11.

Convert for Swift 5.1.3.

## [1.4.8](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.8)

Released on 2019-11-04.

Convert for Swift 5.1.2.

#### Updated
- VoxeetSDK.shared.pushNotification = *VTNotificationService*
    - VoxeetSDK.shared.notification = *VTNotificationService*

## [1.4.7](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.4.7)

Released on 2019-10-14.

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
