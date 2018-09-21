# Change Log

All notable changes to this project will be documented in this file.

#### 1.x Releases
- [1.2.1](#112) Release
- [1.2.0](#112) Release
- [1.1.2](#112) Release
- [1.1.1](#111) Release
- [1.1.0](#110) Release
- [1.0.9](#109) Release
- [1.0.8](#108) Release
- [1.0.7](#107) Release

---

## [1.2.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.1)

Released on 2018-11-21.

Convert for Swift 4.2.

## [1.2.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.2.0)

Released on 2018-11-20.

## [1.1.2](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.2)

Released on 2018-07-10.

Convert for Swift 4.1.2.

## [1.1.1](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.1)

Released on 2018-04-03.

Convert for Swift 4.1.

## [1.1.0](https://github.com/voxeet/voxeet-ios-sdk/releases/tag/1.1.0)

Released on 2018-03-27.

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

#### Added

- VoxeetSDK.shared.conference.alias (custom conference identifier)

#### Updated

- VoxeetSDK.shared.conference.id is now the internal Voxeet identifier for a live conference.

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
