//
//  LJLoginViewController.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/14.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "LJLoginViewController.h"
#import "UINavigationBar+Status.h"
#import "LJLoginVCFactory.h"

@interface LJLoginViewController () <LJCellObjectProtocol>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LJLoginVCFactory *factory;
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation LJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar nav_setBackGroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancle:)];
    
    [self configView];
}

- (void)configView{
    
//    [self.factory getItems];
    [self.view addSubview:self.tableView];
}


- (void)cancle:(UIBarButtonItem *)barItem{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Getter & Setter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self.factory;
        _tableView.delegate = self.factory;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (LJLoginVCFactory *)factory{
    if (!_factory) {
        _factory = [[LJLoginVCFactory alloc] init];
        [_factory getItems];
        _factory.delegate = self;
    }
    return _factory;
}

- (void)dealloc{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
