//
//  UITableViewCell+InitCell.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/7/13.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (InitCell)
+ (id)cellNibWithTableView:(UITableView *)tableView;
+ (id)cellWithTableView:(UITableView *)tableView;
@end
