//
//  OneContentView.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneContentView : UIView

@property (nonatomic,strong)NSArray *OneArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy) void(^toSelectedBlock)(NSIndexPath *indexPath);
+ (id)contentView;

@end
