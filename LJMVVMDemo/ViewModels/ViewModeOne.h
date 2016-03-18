//
//  ViewModeOne.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModeClass.h"
#import "OneModel.h"

@interface ViewModeOne : ViewModeClass

//获取信息数据
- (void)fetchOneData;

//跳转到详情页
- (void)OneDetaiWithOneModel:(OneModel *)model withViewController:(UIViewController *)superController;

@end
