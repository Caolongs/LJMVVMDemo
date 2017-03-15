//
//  LJLoginViewController.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/14.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJLoginViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import "UINavigationBar+Status.h"

@interface LJLoginViewController ()

//@property (strong, nonatomic) AVPlayer *myPlayer;//播放器
//
//@property (strong, nonatomic) AVPlayerItem *item;//播放单元
//
//@property (strong, nonatomic) AVPlayerLayer *playerLayer;//播放界面（layer）

@end

@implementation LJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar nav_setBackGroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancle:)];
    
}

- (void)cancle:(UIBarButtonItem *)barItem{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}




- (void)dealloc{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
