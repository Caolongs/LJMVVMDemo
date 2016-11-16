//
//  LivePlayViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LivePlayViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ViewModelOneLivePlayer.h"
#import "UINavigationBar+Status.h"
#import "LiveDetailModel.h"
#import "OneLiveDetailCell.h"

@interface LivePlayViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) ViewModelOneLivePlayer *viewModel;
@property(nonatomic, strong) UIView *playBackView;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@property(nonatomic, strong) IJKFFMoviePlayerController *player;
@property(nonatomic, strong) NSArray *modelArray;
@property(nonatomic, strong) UIView *headView;//直播，聊天室
@property(nonatomic, strong) UITableView *tableView;


@end

@implementation LivePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.playBackView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(leftBar)];
    
    
    [self loadNewData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.player prepareToPlay];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar nav_setBackGroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar nav_clear];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.player stop];
    [self.player shutdown];
}

#pragma mark - 请求网络及回调
- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getDataWithSkipID:self.skipId success:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        LiveDetailModel *liveModel = modelArray.firstObject;
        if (liveModel) {
            if (liveModel.liveVideoUrl) {
                [weakSelf ijkLivingPlayWitUrlStr:liveModel.liveVideoUrl];
            }else{
                NSArray *mutiArr = liveModel.mutilVideo_lj;
                if (mutiArr.count>0) {
                    Live_mutilVideo *mutilModel = mutiArr.firstObject;
                    [weakSelf ijkLivingPlayWitUrlStr:mutilModel.url];
                }
            }
        }
        [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
    
}

#pragma mark - TableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LiveDetailModel *liveModel = self.modelArray.firstObject;
    if (liveModel) {
        NSArray *arr  = liveModel.messages_lj;
        return arr.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneLiveDetailCell *cell = [OneLiveDetailCell cellNibWithTableView:tableView];
    LiveDetailModel *liveModel = self.modelArray.firstObject;
    NSArray *arr  = liveModel.messages_lj;
    Live_messages *messModel = arr[indexPath.row];
    cell.messageModel = messModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 217;
}


#pragma mark - PrivateMethed
/**
 *  使用ijkPlayer播放
 *
 *  @param urlStr 播放源
 */
- (void)ijkLivingPlayWitUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault]; //使用默认配置
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options]; //初始化播放器，播放在线视频或直播(RTMP)
    // NSString *filePath = [[NSBundle mainBundle] pathForResource:@"init"ofType:@"mp4"];
    // self.player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:filePath withOptions:options]; //初始化播放器，播放本地视频
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.playBackView.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit; //缩放模式
    self.player.shouldAutoplay = YES; //开启自动播放
    self.playBackView.autoresizesSubviews = YES;
    
    [self.playBackView addSubview:self.player.view];
    [self.player prepareToPlay];
    [self.player play];
    
}

/**
 *  z左按钮返回
 *
 */
- (void)leftBar{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Getter & Setter

//视频播放背景View
- (UIView *)playBackView{
    if (_playBackView == nil) {
        _playBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
        _playBackView.backgroundColor = [UIColor blackColor];
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        activity.center = _playBackView.center;
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activity startAnimating];
        _activity = activity;
        [_playBackView addSubview:activity];
    }
    return _playBackView;
}

- (ViewModelOneLivePlayer *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModelOneLivePlayer alloc] init];
    }
    return _viewModel;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playBackView.frame), self.view.frame.size.width, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 2; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(0, 0, 100, 30);
            button.center = CGPointMake(self.view.frame.size.width/3*(1+i), 15);
            [button setTitle:@[@"直播",@"聊天室"][i] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [_headView addSubview:button];
        }
    }
    return _headView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), self.view.frame.size.width, CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.headView.frame)-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
