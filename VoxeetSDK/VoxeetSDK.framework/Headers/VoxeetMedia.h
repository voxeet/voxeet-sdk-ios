//
//  VoxeetMedia.h
//  VoxeetMedia
//
//  Created by Thomas Gourgues on 21/08/12.
//  Copyright (c) 2012 Thomas Gourgues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VoxeetMediaDelegate.h"
#import "AudioCoreCodec.h"
#import "NetworkReporting.h"
#import "AudioSettings.h"

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

struct ICoreMedia;
typedef struct ICoreMedia ICoreMedia;

typedef enum{
    DeviceiPhone    = 0,
    DeviceSpeaker   = 1,
    DeviceBluetooth = 2,
    DeviceHeadset   = 3,
    DeviceNone      = 4
}AudioDevice;

typedef enum{
    LowProfile  = 0,
    HighProfile = 1
}AudioProfile;

typedef enum{
    kNoQos        = 0,
    kQosConnected = 1,
    kQosLost      = 2
}QosStatus;


@interface VoxeetMedia : NSObject <CBCentralManagerDelegate> {
    //ICoreMedia*  m_coreMedia;
    AudioProfile m_profile;
    CBCentralManager *m_manager;
}

//@property (readwrite, nonatomic) CBCentralManager *manager;
@property (nonatomic, assign) id <VoxeetMediaDelegate> delegate;
- (id)initWithLocalPeer:(NSString *)localPeerId audioSettings:(AudioSettings *)settings;
- (BOOL)needSwitchToPstn;
- (BOOL)createConnectionWithPeer:(NSString *)peerId isMaster:(BOOL)isMaster;
- (BOOL)closeConnectionWithPeer:(NSString *)peerId;
- (BOOL)createOfferForPeer:(NSString *)peerId;
- (BOOL)createAnswerForPeer:(NSString *)peerId;
- (BOOL)setDescriptionForPeer:(NSString *)peerId withSsrc:(long)ssrc type:(NSString *)type andSdp:(NSString *)sdp;
- (BOOL)setCandidateForPeer:(NSString *)peerId withsdpMid:(NSString *)sdpMid sdpIndex:(NSInteger)sdpMLineIndex andSdp:(NSString *)sdp;
- (BOOL)setPositionForPeer:(NSString *)peerId withAngle:(double)angle andPosition:(double)position;
- (BOOL)setPositionForPeer:(NSString *)peerId withAngle:(double)angle position:(double)position andGain:(float)gain;
- (BOOL)setGain:(float)gain forPeer:(NSString *)peerId;
- (void)setMute:(BOOL)mute;
- (void)setAudioOptions:(BOOL)ns agc:(BOOL)agc ec:(BOOL)ec typingDetection:(BOOL)typingDetection;
- (NSInteger)getLocalVuMeter;
- (NSInteger)getVuMeterForPeer:(NSString *)peerId;
- (BOOL)setRecordingDevice:(NSInteger)deviceId;
- (NSArray *)getOutputDevicesList;
- (NSArray *)availableAudioDevices;
- (BOOL)hasHeadsetPlugged;
- (void)setLoudSpeakerActive:(BOOL)isActive;
- (BOOL)isLoudSpeakerActive;
- (BOOL)setBluetoothAllowed:(BOOL)isActive;
- (BOOL)isBluetoothAllowed;
- (BOOL)shouldBeMono;
- (void)initAudioSession:(BOOL)isHardwareAEC;
-(void)forceSpeaker:(BOOL)force;
- (void)routeChange:(NSNotification*)notification;
- (void)setCodecQuality:(NSInteger)quality;
- (SenderNetworkReport *)getLocalNeworkReporting;
- (ReceiverNetworkReport *)getNetworkReportingForPeer:(NSString *)peerId;
- (AudioCoreCodec *)getSendCodec;
- (void)audioRouteChangeHandler;
- (void)setHardwareGain:(float)gain;
- (void)reset;
- (void)stopAudioDevice;
- (void)startAudioDevice;
- (void)stop;
- (void) dealloc;
- (void)printTraceWithLevel:(int)level withMessage:(const char*)message ofLength:(int)length;
- (void)callbackOnChannel:(int)channel withErrorCode:(int)errCode;
-(void)stopTimerDelegate;
#pragma mark - Old audio core methods


@end
