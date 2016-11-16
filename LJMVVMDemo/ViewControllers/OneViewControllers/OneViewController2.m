//
//  OneViewController2.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/2.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneViewController2.h"
#import "ViewModeOne2.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "OneCell.h"

@interface OneViewController2 () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) ViewModeOne2 *viewModel;
@property(nonatomic, strong) NSArray *modelArray;

@end

@implementation OneViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----viewController-2");
    [self.view addSubview:self.tableView];
    self.viewModel = [[ViewModeOne2 alloc] init];
    
    [self configureNavBar];
    
    [self configRefresh];
    
//    NSArray *arry=[NSArray arrayWithObject:@"sss"];
//    NSLog(@"%@",[arry objectAtIndex:1]);

    
}
#pragma mark - 配置导航相关
-(void)configureNavBar{
    //self.automaticallyAdjustsScrollViewInsets = YES;//默认YES
    //    self.navigationController.navigationBar.translucent = YES;
    //    self.navigationController.navigationBar.opaque = YES;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor yellowColor];
    
}
#pragma mark - 配置刷新
- (void)configRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    //self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.tableView.mj_header.lastUpdatedTime];
//    if (time<=2 || time > 60) {
//        [self.tableView.mj_header beginRefreshing];
//    }
    
}


#pragma mark - 请求网络及回调
- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    [_viewModel refreshRequestIsHead:YES WithSuccessed:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } WithFailed:^{
        [SVProgressHUD showErrorWithStatus:@"网络差！！"];
        [weakSelf.tableView.mj_header endRefreshing];
    } WithCache:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        [weakSelf.tableView reloadData];
    }];
}
- (void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    [_viewModel refreshRequestIsHead:NO WithSuccessed:^(NSArray *modelArray) {
        weakSelf.modelArray = modelArray;
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
        //weakSelf.contentView.tableView.mj_footer.hidden = YES;
    } WithFailed:^{
        [SVProgressHUD showErrorWithStatus:@"网络差！！"];
        [weakSelf.tableView.mj_footer endRefreshing];
        //[weakSelf.contentView.tableView.mj_footer setHidden:YES];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneCell *cell = [OneCell cellNibWithTableView:tableView];
    cell.model = self.modelArray[indexPath.row];
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


#pragma mark - 动画效果
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //还原
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
}

#pragma mark - Getter & Setter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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
