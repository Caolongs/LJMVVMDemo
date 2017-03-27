//
//  AVAudioSessionManager.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/27.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "AVAudioSessionManager.h"
#import <AVFoundation/AVFoundation.h>

static PermissionBlock _permissionBlock;


@implementation AVAudioSessionManager

+ (void)justPermission:(PermissionBlock)block{
    
    _permissionBlock = block;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
        
        switch (permissionStatus) {
            case AVAudioSessionRecordPermissionUndetermined:{
                NSLog(@"第一次调用，是否允许麦克风弹框");
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    // CALL YOUR METHOD HERE - as this assumes being called only once from user interacting with permission alert!
                    if (granted) {
                        // Microphone enabled code
                        if (_permissionBlock) {
                            _permissionBlock(YES);
                        }
                    }
                    else {
                        // Microphone disabled code
                        if (_permissionBlock) {
                            _permissionBlock(NO);
                        }
                    }
                }];
                break;
            }
            case AVAudioSessionRecordPermissionDenied:
                // direct to settings...
                NSLog(@"已经拒绝麦克风弹框");
                if (_permissionBlock) {
                    _permissionBlock(NO);
                }
                
                break;
            case AVAudioSessionRecordPermissionGranted:
                NSLog(@"已经允许麦克风弹框");
                // mic access ok...
                if (_permissionBlock) {
                    _permissionBlock(YES);
                }
                break;
            default:
                // this should not happen.. maybe throw an exception.
                break;
        }
        if(permissionStatus == AVAudioSessionRecordPermissionUndetermined) return;
    }
}

@end
