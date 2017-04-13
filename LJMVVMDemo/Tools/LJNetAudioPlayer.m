//
//  LJNetAudioPlayer.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJNetAudioPlayer.h"
#import "FSAudioController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FSPlaylistItem.h"
#import "NSTimer+Category.h"

@interface LJNetAudioPlayer ()

@property (nonatomic, strong) NSTimer *progressUpdateTimer;
@property (nonatomic,strong) FSAudioController *audioController;//控制

@end

@implementation LJNetAudioPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self stateChangeFunc];
        [self failureFunc];
        [self metaDataAvailableFunc];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url{
    
    self = [self init];
    if (self) {
        self.audioController.url = url;
       
    }
    return self;
}

- (void)play {
    [self.audioController play];
    
    
}
- (void)pause {
    [self.audioController pause];
}
- (void)stop {
    [self.audioController stop];
}

- (void)playFromPlaylist:(NSArray *)playlist{
    [self.audioController playFromPlaylist:playlist];
}

- (void)playItemAtIndex:(NSUInteger)index{
    [self.audioController playItemAtIndex:index];
}

- (void)addItem:(FSPlaylistItem *)item{
    [self.audioController addItem:item];
}

- (NSUInteger)countOfItems{
    return self.audioController.countOfItems;
}

- (void)stateChangeFunc{
    __weak typeof(self)weakSelf = self;
    self.audioController.onStateChange = ^(FSAudioStreamState state) {
        switch (state) {
            case kFsAudioStreamRetrievingURL:
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                NSLog(@"State change: retrieving URL");
                
                break;
                
            case kFsAudioStreamStopped:
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"State change: stopped");
                [weakSelf invaildateForTimer];
                break;
                
            case kFsAudioStreamBuffering: {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                NSLog(@"State change: buffering");
                
                NSLog(@"%@",[[NSString alloc] initWithFormat:@"Buffering %f seconds...", weakSelf.audioController.activeStream.configuration.requiredPrebufferSizeInSeconds]);
                NSLog(@"%@",[[NSString alloc] initWithFormat:@"Buffering %i bytes...", (weakSelf.audioController.activeStream.continuous ? weakSelf.audioController.configuration.requiredInitialPrebufferedByteCountForContinuousStream :weakSelf.audioController.configuration.requiredInitialPrebufferedByteCountForNonContinuousStream)]);
                
                break;
            }
                
            case kFsAudioStreamSeeking:
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                NSLog(@"State change: seeking");
                
                break;
                
            case kFsAudioStreamPlaying:
                
#if DO_STATKEEPING
                NSLog(@"%@", weakSelf.audioController.activeStream);
#endif
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"State change: playing");
                
                if (!weakSelf.progressUpdateTimer) {
                    weakSelf.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 block:^(NSTimer *timer) {
                        __strong typeof(weakSelf)strongSelf = weakSelf;
                        [strongSelf updatePlaybackProgress];
                    } repeats:YES];
                }
                break;
                
            case kFsAudioStreamFailed:
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"State change: failed");
                break;
            case kFsAudioStreamPlaybackCompleted:
                
                NSLog(@"State change: playback completed");
                [weakSelf invaildateForTimer];
                
                break;
                
            case kFsAudioStreamRetryingStarted:
                NSLog(@"State change: retrying started");
                
                break;
                
            case kFsAudioStreamRetryingSucceeded:
                NSLog(@"State change: retrying succeeded");
                
                break;
                
            case kFsAudioStreamRetryingFailed:
                NSLog(@"State change: retrying failed");
                
                break;
                
            default:
                break;
        }
    };
}

- (void)failureFunc{
    __weak typeof(self)weakSelf = self;
    self.audioController.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
        NSString *errorCategory;
        
        switch (error) {
            case kFsAudioStreamErrorOpen:
                errorCategory = @"Cannot open the audio stream: ";
                break;
            case kFsAudioStreamErrorStreamParse:
                errorCategory = @"Cannot read the audio stream: ";
                break;
            case kFsAudioStreamErrorNetwork:
                errorCategory = @"Network failed: cannot play the audio stream: ";
                break;
            case kFsAudioStreamErrorUnsupportedFormat:
                errorCategory = @"Unsupported format: ";
                break;
            case kFsAudioStreamErrorStreamBouncing:
                errorCategory = @"Network failed: cannot get enough data to play: ";
                break;
            default:
                errorCategory = @"Unknown error occurred: ";
                break;
        }
        
        NSString *formattedError = [NSString stringWithFormat:@"%@ %@", errorCategory, errorDescription];
        NSLog(@"Audio stream failure: %@",formattedError);
        
    };
}

- (void)metaDataAvailableFunc{
    __weak typeof(self)weakSelf = self;
    
    self.audioController.onMetaDataAvailable = ^(NSDictionary *metaData) {
        
        [weakSelf determineStationNameWithMetaData:metaData];
        
        NSMutableString *streamInfo = [[NSMutableString alloc] init];
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        if (metaData[@"MPMediaItemPropertyTitle"]) {
            
            songInfo[MPMediaItemPropertyTitle] = metaData[@"MPMediaItemPropertyTitle"];
        } else if (metaData[@"StreamTitle"]) {
            songInfo[MPMediaItemPropertyTitle] = metaData[@"StreamTitle"];
        }
        
        if (metaData[@"MPMediaItemPropertyArtist"]) {
            songInfo[MPMediaItemPropertyArtist] = metaData[@"MPMediaItemPropertyArtist"];
        }
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
        if (metaData[@"MPMediaItemPropertyArtist"] &&
            metaData[@"MPMediaItemPropertyTitle"]) {
            [streamInfo appendString:metaData[@"MPMediaItemPropertyArtist"]];
            [streamInfo appendString:@" - "];
            [streamInfo appendString:metaData[@"MPMediaItemPropertyTitle"]];
        } else if (metaData[@"StreamTitle"]) {
            [streamInfo appendString:metaData[@"StreamTitle"]];
        }
        
        if (metaData[@"StreamUrl"] && [metaData[@"StreamUrl"] length] > 0) {
            
            NSLog(@"%@",metaData[@"StreamUrl"]);
        }
        
        if (metaData[@"CoverArt"]) {
            //            FSAppDelegate *delegate = [UIApplication sharedApplication].delegate;
            //            NSData *data = [[NSData alloc] initWithBase64EncodedString:metaData[@"CoverArt"] options:0];
            //            UIImage *coverArt = [UIImage imageWithData:data];
            //            delegate.window.backgroundColor = [UIColor colorWithPatternImage:coverArt];
        }
        
        NSLog(@"Meta data received: %@", streamInfo);
        
    };
}




#pragma mark - Private Method

- (void)updatePlaybackProgress
{
    if (self.audioController.activeStream.continuous) {
        //        [self.progressTextFieldCell setTitle:@""];
    } else {
        FSStreamPosition cur = self.audioController.activeStream.currentTimePlayed;
        FSStreamPosition end = self.audioController.activeStream.duration;
        CGFloat loadTime = cur.minute *60 + cur.second;
        CGFloat totalTime = end.minute*60 + end.second;
        NSString *loadDate = [NSString stringWithFormat:@"%i:%02i",cur.minute, cur.second];
        NSString *totalDate = [NSString stringWithFormat:@"%i:%02i",end.minute, end.second];
        if (self.progressBlock) {
            self.progressBlock(loadTime/totalTime,loadDate,totalDate);
        }
        //        NSLog(@"%@",[NSString stringWithFormat:@"%i:%02i / %i:%02i",
        //                     cur.minute, cur.second,
        //                     end.minute, end.second]);
    }
}


- (void)determineStationNameWithMetaData:(NSDictionary *)metaData
{
    if (metaData[@"IcecastStationName"] && [metaData[@"IcecastStationName"] length] > 0) {
//        self.navigationController.navigationBar.topItem.title = metaData[@"IcecastStationName"];
    } else {
        FSPlaylistItem *playlistItem = self.audioController.currentPlaylistItem;
//        NSString *title = playlistItem.title;
        
        if ([playlistItem.title length] > 0) {
//            self.navigationController.navigationBar.topItem.title = title;
        } else {
            /* The last resort - use the URL as the title, if available */
            if (metaData[@"StreamUrl"] && [metaData[@"StreamUrl"] length] > 0) {
//                self.navigationController.navigationBar.topItem.title = metaData[@"StreamUrl"];
            }
        }
    }
}

- (void)invaildateForTimer{
    if ([self.progressUpdateTimer isValid]) {
        [_progressUpdateTimer invalidate];
    }
    _progressUpdateTimer = nil;
}


#pragma mark - Getter & Setter
- (FSAudioController *)audioController
{
    if (!_audioController) {
        _audioController = [[FSAudioController alloc] init];
    }
    return _audioController;
}


- (void)dealloc {

    [_progressUpdateTimer invalidate];
    _progressUpdateTimer = nil;
}

@end
