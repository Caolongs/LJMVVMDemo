//
//  LJTableViewCell.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/15.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCellObjectProtocol.h"

@interface LJTableViewCell : UITableViewCell

@property (nonatomic, weak) id<LJCellObjectProtocol> delegate;

- (void)configCellObject:(id)object;

@end
