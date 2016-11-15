//
//  UINavigationBar+Status.m
//  1009_04-状态栏
//
//  Created by caolongjian on 15/10/9.
//  Copyright (c) 2015年 曹. All rights reserved.
//

#import "UINavigationBar+Status.h"
#import <objc/runtime.h>

static char key;
@implementation UINavigationBar (Status)

- (UIView *)bgView
{
    
    return objc_getAssociatedObject(self, &key);
}
- (void)setBgView:(UIView *)bgView
{
    objc_setAssociatedObject(self, &key, bgView, OBJC_ASSOCIATION_ASSIGN);
}
- (void)nav_setBackGroundColor:(UIColor *)backgroundColor
{
    if (self.bgView == nil) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.bgView = bgView;
        
        //添加到navagationBar 最底层
        [self insertSubview:bgView atIndex:0];
        
        //让navagationBar没有颜色
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        //去掉阴影线
        [self setShadowImage:[UIImage new]];
    }
    
    
    self.bgView.backgroundColor = backgroundColor;
}
- (void)nav_clear
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
}
@end
