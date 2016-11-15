//
//  ViewControllerTwo.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "YZLiveCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YZLiveItem.h"
#import "LiveViewController.h"
#import "MJRefresh.h"


static NSString * const ID = @"cell";
@interface ViewControllerTwo () <UITableViewDelegate, UITableViewDataSource>
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"映客直播";
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];

    // 加载数据
    [self configRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 配置刷新
- (void)configRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    //MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    //self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData
{
    // 映客数据url  133825214 230606576
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=230606576&interest=1";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        _lives = [YZLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.live = _lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewController *liveVc = [[LiveViewController alloc] init];
    liveVc.live = _lives[indexPath.row];
    
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
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
