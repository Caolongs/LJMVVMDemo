//
//  OneLiveListCellTableViewCell.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseCell.h"
@class LiveListModel;

@interface OneLiveListCell : LJBaseCell
@property(nonatomic, strong) LiveListModel *model;

@end
