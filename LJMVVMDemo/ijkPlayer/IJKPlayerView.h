//
//  IJKPlayerView.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 17/3/15.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@protocol fullScreenDelegate <NSObject>

-(void)btnFullScreenDidClick:(UIButton *)sender;

@end

@protocol backDelegate <NSObject>

-(void)btnBackClick:(UIButton *)sender;

@end

@interface IJKPlayerView : UIView

@property (nonatomic,copy)NSString * url;
@property (nonatomic,strong)IJKFFMoviePlayerController * player;
@property (nonatomic,strong)id<fullScreenDelegate> fullScreenDelegate;
@property (nonatomic,strong)id<backDelegate> backDelegate;

@property (nonatomic,strong)UIView * cover;


-(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate url:(NSString *)url;

@end
