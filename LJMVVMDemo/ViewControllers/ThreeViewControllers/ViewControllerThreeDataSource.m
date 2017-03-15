//
//  ViewControllerThreeDataSource.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/10.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "ViewControllerThreeDataSource.h"
#import "LJTableViewCell.h"

@interface ViewControllerThreeDataSource ()



@end

@implementation ViewControllerThreeDataSource



- (NSMutableArray<LJCellObject *> *)getItems{
    [self.itemArray removeAllObjects];
    
    NSArray *dataArray = @[@"UITableView-searcSh",@"UISerachViewController",@"javaScripCore",@"ContactsDemo",@"二维码",@"4.safe-dictionary-array",@"pdf预览"];
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJCellObject *cellObject1 = [[LJCellObject alloc] init];
        cellObject1.cellClass = [LJTableViewCell class];
        cellObject1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cellObject1.title = dataArray[idx];
        [self.itemArray addObject:cellObject1];
    }];
    
    
    return self.itemArray;
}



@end
