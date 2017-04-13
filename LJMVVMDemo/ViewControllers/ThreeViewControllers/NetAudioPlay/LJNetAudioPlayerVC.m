//
//  LJNetAudioPlayerVC.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJNetAudioPlayerVC.h"
#import "LJNetAudioPlayer.h"

@interface LJNetAudioPlayerVC ()

@property (nonatomic, strong) LJNetAudioPlayer *audioPlayer;

@end

@implementation LJNetAudioPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //NSURL *url =  [[NSBundle mainBundle] URLForResource:@"aaa.mp3" withExtension:nil];
    _audioPlayer = [[LJNetAudioPlayer alloc] initWithUrl:@"http://mp3tuijian.9ku.com/tuijian/2015/07-06/665486.mp3"];
    [_audioPlayer play];
    
    [self.audioPlayer setProgressBlock:^(CGFloat f, NSString *loadTime, NSString *totalTime) {
        NSLog(@"%f ---- %@/%@",f,loadTime,totalTime);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
