//
//  LiveViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/10/5.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "YZliveItem.h"
#import "YZCreatorItem.h"
#import "UIImageView+WebCache.h"

@interface LiveViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) IJKFFMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIButton *btnDis;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.btnDis setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    
    //设置占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_live.creator.portrait]];
    [self.imageView sd_setImageWithURL:imageUrl];
    
    //拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    
    //创建IJKFFMoviewPlayerController:专门用来直播，传入拉流地址就好
    IJKFFMoviePlayerController *playerVC = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    //准备播放
    [playerVC prepareToPlay];
    
    //强引用，反正被销毁
    _player = playerVC;
    
    playerVC.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVC.view atIndex:1];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //界面消失，停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (IBAction)btnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
