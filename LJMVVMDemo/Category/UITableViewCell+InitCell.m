//
//  UITableViewCell+InitCell.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/7/13.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "UITableViewCell+InitCell.h"

@implementation UITableViewCell (InitCell)

+ (id)cellNibWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
    
}
+ (id)cellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}
@end
