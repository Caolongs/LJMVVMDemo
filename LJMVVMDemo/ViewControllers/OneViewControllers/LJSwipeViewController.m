//
//  LJSwipeViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/7/27.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJSwipeViewController.h"
#import "ViewControllerOne.h"
#import "OneViewController2.h"
#import "OneViewController3.h"
#import "OneViewController4.h"
#import "LiveMovieViewController.h"


@interface LJSwipeViewController () < VTMagicViewDataSource >
{
    NSArray *_listTitle;
}

@end

@implementation LJSwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.sliderColor = [UIColor redColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    //self.magicView.navigationHeight = 40.f;
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    self.magicView.needPreloading = NO;//预加载
    
    
    _listTitle = @[@"头条",@"精选",@"娱乐",@"直播",@"科技",@"图片",@"网易号"];
    [self.magicView reloadData];
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return _listTitle;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    if (pageIndex == 0) {
        static NSString *recomId = @"one.identifier";
        ViewControllerOne *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!recomViewController) {
            recomViewController = [[ViewControllerOne alloc] init];
        }
        return recomViewController;
    }else if (pageIndex == 1){
        static NSString *recomId2 = @"two.identifier";
         OneViewController2 *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId2];
        if (!recomViewController) {
            recomViewController = [[OneViewController2 alloc] init];
            //recomViewController.view.backgroundColor = RANDOM_COLOR;
        }
        return recomViewController;
    }else if(pageIndex == 2){
        static NSString *recomId3 = @"two2.identifier";
        OneViewController3 *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId3];
        if (!recomViewController) {
            recomViewController = [[OneViewController3 alloc] init];
            //recomViewController.view.backgroundColor = RANDOM_COLOR;
        }
        return recomViewController;
    }else if(pageIndex == 3){
        static NSString *recomId3 = @"two2.identifier";
        LiveMovieViewController *liveViewController = [magicView dequeueReusablePageWithIdentifier:recomId3];
        if (!liveViewController) {
            liveViewController = [[LiveMovieViewController alloc] init];
        }
        return liveViewController;
    }else{
        static NSString *recomId4 = @"two4.identifier";
        OneViewController4 *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId4];
        if (!recomViewController) {
            recomViewController = [[OneViewController4 alloc] init];
            //recomViewController.view.backgroundColor = RANDOM_COLOR;
        }
        return recomViewController;
    }

}

@end
