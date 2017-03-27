//
//  AVAudioSessionManager.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/27.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PermissionBlock)(BOOL granted);

@interface AVAudioSessionManager : NSObject

+ (void)justPermission:(PermissionBlock)block;

@end
