//
//  LJLoginVCFactory.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/15.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJLoginVCFactory.h"
#import "LJTableViewCell.h"

@implementation LJLoginVCFactory

- (NSMutableArray<LJCellObject *> *)getItems{
    [self.itemArray removeAllObjects];
    
    NSArray *dataArray = @[@"UITableView-searcSh",@"UISerachViewController",@"javaScripCore",@"ContactsDemo",@"二维码",@"4.safe-dictionary-array",@"pdf预览"];
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJCellObject *cellObject1 = [[LJCellObject alloc] init];
        cellObject1.cellClass = [LJTableViewCell class];
        cellObject1.cellHeight = 50;
        cellObject1.title = dataArray[idx];
        [self.itemArray addObject:cellObject1];
    }];
    
    
    return self.itemArray;
}

@end
