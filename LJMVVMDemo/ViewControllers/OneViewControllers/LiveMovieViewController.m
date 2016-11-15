//
//  LiveMovieViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LiveMovieViewController.h"
#import "ViewModelOneLive.h"
#import "HYBLoopScrollView.h"
#import "MJRefresh.h"
#import "LiveListModel.h"
#import "OneLiveListCell.h"

@interface LiveMovieViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) ViewModelOneLive *viewModel;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *modelArray;
@property(nonatomic, strong) HYBLoopScrollView *headerView;
@property(nonatomic, assign) NSInteger pageNum;

@end

@implementation LiveMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNum = 0;
    _modelArray = [NSMutableArray array];
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
    _pageNum = 0;
    [self.modelArray removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [self.viewModel getDataWithPageNum:0 success:^(NSArray *modelArray) {
        weakSelf.modelArray = (NSMutableArray *)modelArray;
        weakSelf.headerView.imageUrls = @[((LiveListModel *)modelArray.firstObject).imgsrc];
        [weakSelf.tableView reloadData];
        weakSelf.headerView.adTitles = @[((LiveListModel *)modelArray.firstObject).title];
        [weakSelf.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}
- (void)loadMoreData{
    _pageNum++;
    __weak typeof(self) weakSelf = self;
    [self.viewModel getDataWithPageNum:_pageNum success:^(NSArray *modelArray) {
        [weakSelf.modelArray addObjectsFromArray:modelArray];
        weakSelf.headerView.imageUrls = @[((LiveListModel *)weakSelf.modelArray.firstObject).imgsrc];
        [weakSelf.tableView reloadData];
        weakSelf.headerView.adTitles = @[((LiveListModel *)weakSelf.modelArray.firstObject).title];
        [weakSelf.tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneLiveListCell *cell = [OneLiveListCell cellNibWithTableView:tableView];
    cell.model = self.modelArray[indexPath.row+1];
    
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.viewModel toNextViewControllerWithOneModel:self.modelArray[indexPath.row+1] superViewController:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


#pragma mark - Action&Response

#pragma mark - PrivateMethod

#pragma mark - Setter&Getter
- (ViewModelOneLive *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModelOneLive alloc] init];
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
        __weak typeof(self)weakSelf = self;
        HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 173) imageUrls:nil timeInterval:5 didSelect:^(NSInteger atIndex) {
            [weakSelf.viewModel toNextViewControllerWithOneModel:weakSelf.modelArray.firstObject superViewController:weakSelf];
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
