//
//  LJTabBarController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJTabBarController.h"
#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"
#import "ViewControllerThree.h"
#import "ViewControllerFour.h"
#import "LJNavigationController.h"

@interface LJTabBarController ()

@end

@implementation LJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewControllerOne *one = [[ViewControllerOne alloc] init];
    [self setItemWithController:one title:@"One" imageName:@"tabbar_cookbook_normal" selectedImageName:@"tabbar_cookbook_hightlight"];
    
    ViewControllerTwo *two = [[ViewControllerTwo alloc] init];
    [self setItemWithController:two title:@"Two" imageName:@"tabbar_like_normal" selectedImageName:@"tabbar_like_hightlight"];
    
    ViewControllerThree *three = [[ViewControllerThree alloc] init];
    [self setItemWithController:three title:@"Three" imageName:@"tabbar_lesson_normal" selectedImageName:@"tabbar_lesson_hightlight"];
    
    ViewControllerFour *four = [[ViewControllerFour alloc] init];
    [self setItemWithController:four title:@"Four" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_hightlight"];
    
    
}


- (void)setItemWithController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    controller.navigationItem.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    //设置颜色属性
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    [controller.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateSelected];
    
    LJNavigationController *nav = [[LJNavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.barTintColor = [UIColor orangeColor];
    
    //self.tabBar.barStyle = UIBarStyleBlack;
    [self addChildViewController:nav];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
