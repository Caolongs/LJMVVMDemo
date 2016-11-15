//
//  LJGuideViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/23.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJGuideViewController.h"

@interface LJGuideViewController () <UIScrollViewDelegate>
{
    NSArray *_imagesArray;
}
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) UIButton *startbutton;

@end

//检验版本是否更新
BOOL checkAppVersion(void)
{
    //得到当前应用的版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDict[@"CFBundleShortVersionString"];
    //取出之前保存的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appVersion = [userDefaults stringForKey:@"appVersion"];
    if (appVersion == nil || ![appVersion isEqualToString:currentAppVersion]) {
        //保存最新的版本号
        [userDefaults setValue:currentAppVersion forKey:@"appVersion"];
        
//        LJGuideViewController *guideViewController = [[LJGuideViewController alloc] init];
//        [guideViewController setBtnBlock:^{
//            LJTabBarController *tabBarController = [[LJTabBarController alloc] init];
//            self.window.rootViewController = tabBarController;
//        }];
//        self.window.rootViewController = guideViewController;
        return YES;
    }else{
        return NO;
    }
}


@implementation LJGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagesArray = @[@"",@"",@""];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self createImageViews];
        
    
}
- (void)createImageViews{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    for (int i = 0; i < _imagesArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*screenSize.width, 0, screenSize.width, screenSize.height)];
        imgView.image = [UIImage imageNamed:_imagesArray[i]];
        imgView.backgroundColor = RANDOM_COLOR;
        [self.scrollView addSubview:imgView];
        
    }
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(screenSize.width*_imagesArray.count, screenSize.height);
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _pageControl.numberOfPages = _imagesArray.count;
        _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height-100);
        
    }
    return _pageControl;
}


- (UIButton *)startbutton{
    if (_startbutton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame = CGRectMake(0, 0, 100, 30);
        button.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height-140);
        [button setBackgroundColor:[UIColor blueColor]];
        [button setTitle:@"开始体验" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0.0;
        button.layer.cornerRadius = 15;
        [self.view addSubview:button];
        _startbutton = button;
    }
    return _startbutton;
}
- (void)btnClick{
    if (self.btnBlock) {
        self.btnBlock();
    }
}

#pragma mark - UIscrllViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger pageNum = scrollView.contentOffset.x/self.view.bounds.size.width;
    self.pageControl.currentPage = pageNum;
    
    //显示按钮
    self.startbutton.alpha = 0.0;
    if (pageNum==_imagesArray.count-1) {
        [UIView animateWithDuration:0.4 animations:^{
            self.startbutton.alpha = 1.0;
        }];
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            self.startbutton.alpha = 0.0;
        }];
    }
    
    
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
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
