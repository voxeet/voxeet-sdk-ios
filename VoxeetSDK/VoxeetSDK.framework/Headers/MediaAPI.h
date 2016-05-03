//
//  MediaAPI.h
//  VoxeetMedia
//
//  Created by Gilles Bordas on 09/01/2014.
//  Copyright (c) 2014 Voxeet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoxeetMedia.h"
#import "AudioSettings.h"
#import "SdpMessage.h"
#import "SdpCandidates.h"
#import "SdpDescription.h"
#import "SenderNetworkStatistics.h"
#import "ReceiverNetworkStatistics.h"
#import "NetworkCodec.h"

@interface MediaAPI : NSObject <VoxeetMediaDelegate, AudioSettingsDelegate>

@property (strong, nonatomic) NSMutableDictionary *pendingOperations;
@property (strong, nonatomic) SdpCandidates *peerCandidates;

@property (strong, nonatomic) VoxeetMedia *wrapper;
@property (strong ,nonatomic) AudioSettings *audioSettings;

@property (copy, nonatomic) void(^audioRouteChangedBlock)(NSNumber *);

- (id)initWithLocalUser:(NSString *)localUserId settings:(AudioSettings *)audioSettings andAudioRouteChangedBlock:(void(^)(NSNumber *))routeChangedBlock;
- (void)reset;
-(void)forceSpeaker:(BOOL)force;
- (void)stopAudioDevice;
- (void)startAudioDevice;
- (void)stop;
- (void)initAudioSession:(BOOL)isHardwareAEC;
- (BOOL)needSwitchToPstn;
- (SdpMessage *)createOfferForPeer:(NSString *)peerId isMaster:(BOOL)isMaster;
- (SdpMessage *)createAnswerForPeer:(NSString *)peerId withSSRC:(UInt32)ssrc offer:(SdpDescription *)offer andCandidates:(NSArray *)candidates isMaster:(BOOL)isMaster;
- (void)addPeerFromAnswer:(NSString *)peerId withSSRC:(long)ssrc answer:(SdpDescription *)answer candidates:(NSArray *)candidates;
- (void)removePeer:(NSString *)peerId;
- (void)changePeerPosition:(NSString *)peerId withAngle:(double)angle andDistance:(double)distance;
- (void)changePeerPosition:(NSString *)peerId withAngle:(double)angle distance:(double)distance andGain:(float)gain;
- (void)changeGain:(float)gain forPeer:(NSString *)peerId;

- (void)muteRecording;
- (void)unmuteRecording;
- (double)getLocalVuMeterLevel;
- (double)getPeerVuMeterLevel:(NSString *)peerId;
- (SenderNetworkStatistics *)getLocalNetworkReporting;
- (ReceiverNetworkStatistics *)getPeerNetworkReporting:(NSString *)peerId;

- (NetworkCodec *)getPeerNetworkCodec;
- (void)updateQuality:(int)qualityValue;
- (NSArray *)getDevicesList;
- (BOOL)hasHeadsetPlugged;
- (void)SetHardwareAEC:(BOOL)isAEC;
- (void)setLoudSpeakerActive:(BOOL)isActive;
- (BOOL)isLoudSpeakerActive;
- (BOOL)shouldBeMono;
- (void)stopTimerDelegate;

@end