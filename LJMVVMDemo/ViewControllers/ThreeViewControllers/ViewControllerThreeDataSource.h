//
//  ViewControllerThreeDataSource.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/10.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJCellObject.h"

//@class LJCellObject;
@interface ViewControllerThreeDataSource : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIViewController *viewControllerDelegate;

- (NSMutableArray<LJCellObject *> *)getItems;

@property (nonatomic, weak) id<LJCellObjectDelegate> delegate;

@end
