//
//  LJNavigationController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJNavigationController.h"

@interface LJNavigationController ()

@end

@implementation LJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    //...
    [super pushViewController:viewController animated:YES];
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
