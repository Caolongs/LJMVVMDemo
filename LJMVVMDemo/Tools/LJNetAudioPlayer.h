//
//  LJNetAudioPlayer.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FSPlaylistItem;
@interface LJNetAudioPlayer : NSObject

- (instancetype)initWithUrl:(NSURL *)url;

@property (nonatomic,copy) void (^progressBlock)(CGFloat f,NSString *loadTime,NSString *totalTime);

- (void)play;

- (void)pause;

- (void)stop;

- (void)playFromPlaylist:(NSArray *)playlist;

- (void)playItemAtIndex:(NSUInteger)index;

- (void)addItem:(FSPlaylistItem *)item;

- (NSUInteger)countOfItems;

@end
