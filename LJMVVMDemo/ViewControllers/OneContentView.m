//
//  OneContentView.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneContentView.h"
#import "OneCell.h"

@interface OneContentView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;


@end

@implementation OneContentView

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height-64-64)];
        //_tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
    
}

+ (id)contentView{
    return [[self alloc] init];
    
}

- (void)setOneArray:(NSArray *)OneArray{
    _OneArray = OneArray;
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _OneArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneCell *cell = [OneCell subjectCellWithTableView:tableView];
    cell.model = self.OneArray[indexPath.row];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.frame = newSuperview.frame;

//    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, -69);
    //self.tableView.backgroundColor = [UIColor yellowColor];
}

@end
