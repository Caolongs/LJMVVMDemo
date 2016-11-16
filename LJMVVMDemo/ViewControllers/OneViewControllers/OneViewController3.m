//
//  OneViewController3.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/3.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneViewController3.h"
#import "ViewModelOne3.h"
#import "OneCell.h"
#import "MJRefresh.h"
#import "HYBLoopScrollView.h"
#import "News.h"

@interface OneViewController3 () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) ViewModelOne3 *viewModel;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *modelArray;
@property(nonatomic, strong) HYBLoopScrollView *headerView;

@end

@implementation OneViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----viewController-3");
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];
    [self configRefresh];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - 配置刷新
- (void)configRefresh{
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self loadNewData];
     }];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 请求网络及回调
- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getDataWithPageNum:0 success:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        self.headerView.imageUrls = @[((News *)modelArray.firstObject).imgsrc,((News *)modelArray.firstObject).imgsrc];
        [weakSelf.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    } cache:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        [weakSelf.tableView reloadData];
    }];
    
}
- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneCell *cell = [OneCell cellNibWithTableView:tableView];
    cell.newsModel = self.modelArray[indexPath.row];
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (self.toSelectedBlock) {
    //        self.toSelectedBlock(indexPath);
    //    }
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - Action&Response

#pragma mark - PrivateMethod

#pragma mark - Setter&Getter
- (ViewModelOne3 *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModelOne3 alloc] init];
    }
    return _viewModel;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-95) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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
        loop.adTitles = @[@"hahahha",@"哈哈哈哈"];
        
        [self.view addSubview:loop];
        _headerView = loop;
    }
    return _headerView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
