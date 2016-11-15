//
//  OneContentView.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneContentView.h"
#import "OneCell.h"
#import "UITableViewCell+InitCell.h"
#import "HYBLoopScrollView.h"
#import "OneAdsModel.h"

@interface OneContentView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) HYBLoopScrollView *headerView;

@end

@implementation OneContentView

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-64-49)];
        //_tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    
    //头部滚动视图
    OneModel *model = OneArray.firstObject;
    NSArray *arr = model.adsArr;
    NSMutableArray *arrImgsM = [NSMutableArray arrayWithCapacity:arr.count];
    NSMutableArray *arrTitsM = [NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OneAdsModel *adsModel = obj;
        [arrImgsM addObject:adsModel.imgsrc];
        [arrTitsM addObject:adsModel.title];
    }];
    if (arrImgsM.count>0) {
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.imageUrls = arrImgsM;
        self.headerView.adTitles  = arrTitsM;
    }
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _OneArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneCell *cell = [OneCell cellNibWithTableView:tableView];
    cell.model = self.OneArray[indexPath.row];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.toSelectedBlock) {
        self.toSelectedBlock(indexPath);
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (HYBLoopScrollView *)headerView{
    if (_headerView == nil) {
        //__weak typeof(self)weakSelf = self;
        HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) imageUrls:nil timeInterval:5 didSelect:^(NSInteger atIndex) {
            
        } didScroll:^(NSInteger toIndex) {
            
        }];
        
        loop.shouldAutoClipImageToViewSize = YES;
        loop.placeholder = [UIImage imageNamed:@"default.png"];
        
        loop.alignment = kPageControlAlignRight;
        //loop.adTitles = @[@"hahahha",@"哈哈哈哈"];
        
        _headerView = loop;
    }
    return _headerView;
}



- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = newSuperview.bounds;
    //self.frame = CGRectMake(0, -64, newSuperview.bounds.size.width, newSuperview.bounds.size.height-44);

//    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, -69);
    //self.tableView.backgroundColor = [UIColor yellowColor];
}

@end
