//
//  LJMovieBackViewController.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/14.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJMovieBackViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LJMovieBackViewController ()

@property (strong, nonatomic) AVPlayer *myPlayer;//播放器

@property (strong, nonatomic) AVPlayerItem *item;//播放单元

@property (strong, nonatomic) AVPlayerLayer *playerLayer;//播放界面（layer）

@end

@implementation LJMovieBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL*mediaURL = [[NSBundle mainBundle] URLForResource:@"launch" withExtension:@"mp4"];
    self.item= [AVPlayerItem playerItemWithURL:mediaURL];
    
    self.myPlayer= [AVPlayer playerWithPlayerItem:self.item];
    
    self.playerLayer= [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    
    self.playerLayer.frame=[UIScreen mainScreen].bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.playerLayer];
    //self.myPlayer.allowsExternalPlayback = NO;
    
    [self addNotification];
    [self addObserverToPlayerItem:self.item];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self.myPlayer play];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.myPlayer pause];
}


/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.myPlayer.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - KVO
/** * 给AVPlayerItem添加监控 *
 * @param playerItem AVPlayerItem对象 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

/** * 通过KVO监控播放器状态 *
 * @param keyPath 监控属性
 * @param object 监视器
 * @param change 状态改变
 * @param context 上下文 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            [self.myPlayer play];
        }
    }
    else if([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}

- (void)loopPlay:(NSNotification *)notification{

    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.myPlayer seekToTime:CMTimeMake(0, 1)];
    [self.myPlayer play];
}



- (void)dealloc{
    [self removeObserverFromPlayerItem:self.item];
    [self removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
