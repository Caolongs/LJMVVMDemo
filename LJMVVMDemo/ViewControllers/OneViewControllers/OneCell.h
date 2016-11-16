//
//  OneCell.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneModel.h"
#import "LJBaseCell.h"
#import "News.h"

@interface OneCell : LJBaseCell

@property (nonatomic, strong)OneModel *model;

@property(nonatomic, strong) News *newsModel;//coredata 数据

@end
