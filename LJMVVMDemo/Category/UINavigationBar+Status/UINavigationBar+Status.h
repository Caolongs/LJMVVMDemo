//
//  UINavigationBar+Status.h
//  1009_04-状态栏
//
//  Created by caolongjian on 15/10/9.
//  Copyright (c) 2015年 曹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Status)
@property (nonatomic, weak)UIView *bgView;
- (void)nav_setBackGroundColor:(UIColor *)bgroundColor;
- (void)nav_clear;
@end
