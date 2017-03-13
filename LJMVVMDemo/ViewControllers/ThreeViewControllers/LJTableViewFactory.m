//
//  LJTableViewFactory.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJTableViewFactory.h"


@interface LJTableViewFactory ()



@end

@implementation LJTableViewFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemArray = [NSMutableArray array];
    }
    return self;
}
- (NSMutableArray<LJCellObject *> *)getItems{
    
    return nil;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    LJCellObject *cellObj = self.itemArray[indexPath.row];
    
    [tableView registerClass:cellObj.cellClass forCellReuseIdentifier:NSStringFromClass(cellObj.class)];
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellObj.class)];
    cell.textLabel.text = cellObj.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lj_tableView:didSelectRowType:didSelectRowAtIndexPath:)]) {
        [self.delegate lj_tableView:tableView didSelectRowType:@"" didSelectRowAtIndexPath:indexPath];
    }
    
}

@end
