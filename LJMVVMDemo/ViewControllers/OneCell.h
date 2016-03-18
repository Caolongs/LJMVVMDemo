//
//  OneCell.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneModel.h"

@interface OneCell : UITableViewCell

@property (nonatomic, strong)OneModel *model;

+ (id)subjectCellWithTableView:(UITableView *)tableView;

@end
