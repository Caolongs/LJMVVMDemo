//
//  LJTableViewFactory.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJCellObject.h"
#import "LJCellObjectProtocol.h"

@interface LJTableViewFactory : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<LJCellObjectProtocol> delegate;

@property (nonatomic, strong) NSMutableArray<LJCellObject *> *itemArray;
- (NSMutableArray<LJCellObject *> *)getItems;

@end
