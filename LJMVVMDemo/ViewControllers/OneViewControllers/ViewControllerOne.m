//
//  ViewControllerOne.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewControllerOne.h"
#import "viewModeOne.h"
#import "OneContentView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface ViewControllerOne ()

@property (nonatomic,strong) ViewModeOne *viewModel;
@property (nonatomic,strong) OneContentView *contentView;
@property(nonatomic, strong) NSArray *arrayLists;

@end

@implementation ViewControllerOne



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----viewController-1");
    
    
    self.viewModel = [[ViewModeOne alloc] init];
    
    [self configureNavBar];
    
    [self configRefresh];
    
    __weak typeof(self) weakSelf = self;
    [self.contentView setToSelectedBlock:^(NSIndexPath *indexPath) {
        [weakSelf.viewModel toNextViewControllerWithOneModel:weakSelf.contentView.OneArray[indexPath.row] superViewController:weakSelf];
    }];
    
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
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.contentView.tableView.mj_header = header;
    self.contentView.tableView.mj_footer = footer;
    [self.contentView.tableView.mj_header beginRefreshing];
}


#pragma mark - 请求网络及回调
- (void)loadNewData{
    __weak typeof(self) weakSelf = self;
    [_viewModel refreshRequestIsHead:YES WithSuccessed:^(NSArray *modelArray) {
        weakSelf.contentView.OneArray = modelArray;
        [weakSelf.contentView.tableView.mj_header endRefreshing];
    } WithFailed:^{
        [SVProgressHUD showErrorWithStatus:@"网络差！！"];
        [weakSelf.contentView.tableView.mj_header endRefreshing];
    } WithCache:^(NSArray *modelArray) {
        weakSelf.contentView.OneArray = modelArray;
    }];
}
- (void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    [_viewModel refreshRequestIsHead:NO WithSuccessed:^(NSArray *modelArray) {
        weakSelf.contentView.OneArray = modelArray;
        [weakSelf.contentView.tableView.mj_footer endRefreshing];
        //weakSelf.contentView.tableView.mj_footer.hidden = YES;
    } WithFailed:^{
        [SVProgressHUD showErrorWithStatus:@"网络差！！"];
        [weakSelf.contentView.tableView.mj_footer endRefreshing];
        //[weakSelf.contentView.tableView.mj_footer setHidden:YES];
    }];
}


#pragma mark - Getter and Setter
- (OneContentView *)contentView{
    if (_contentView == nil) {
        _contentView = [OneContentView contentView];
        [self.view addSubview:_contentView];
    }
    return _contentView;
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
