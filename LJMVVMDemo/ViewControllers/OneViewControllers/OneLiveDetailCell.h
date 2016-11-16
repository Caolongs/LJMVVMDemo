//
//  OneLiveDetailCell.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/10/1.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LJBaseCell.h"

@class Live_messages;
@interface OneLiveDetailCell : LJBaseCell

@property(nonatomic, strong) Live_messages *messageModel;

@end
