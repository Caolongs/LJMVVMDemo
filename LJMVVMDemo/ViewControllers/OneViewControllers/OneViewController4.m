//
//  OneViewController4.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/3.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneViewController4.h"

@interface OneViewController4 ()

@end

@implementation OneViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----viewController-4");
    self.view.backgroundColor = RANDOM_COLOR;
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
