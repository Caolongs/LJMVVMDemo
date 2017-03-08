//
//  ViewControllerThree.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewControllerThree.h"
#import "UITableViewCell+InitCell.h"
#import "ViewControllerThree1.h"
#import "LJUISearchBarVC.h"
#import "WebViewWK_VC.h"
#import "ContactsViewController.h"
#import "QRCodeViewController.h"
#import "SafeTestViewController.h"

@interface ViewControllerThree () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;


@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor purpleColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    //self.tabBarController.tabBar.translucent = NO;
    
    //=NO时 tableView全屏   CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)
    //self.automaticallyAdjustsScrollViewInsets = NO;//取消自动滚动调整，默认为YES
    //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 60, 0);
    //NO时，内边距不会影响，修改contentInset是多少就是页面显示就是多少，不会和系统自动调整冲突
    
    self.tableView.backgroundColor = [UIColor cyanColor];
    //UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    //self.edgesForExtendedLayout = UIRectEdgeNone;//iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
    
    //v.backgroundColor = [UIColor redColor];
    //[self.view addSubview:v];
    
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        //ViewControllerThree1 *oneVC = [[ViewControllerThree1 alloc] init];
        ViewControllerThree1 *oneVC = [[ViewControllerThree1 alloc] initWithNibName:@"ViewControllerThree1" bundle:nil];
        [self.navigationController pushViewController:oneVC animated:YES];
    }else if (indexPath.row == 1){
        LJUISearchBarVC *searchVC = [[LJUISearchBarVC alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }else if (indexPath.row == 2){
        ContactsViewController *contactVC = [[ContactsViewController alloc] init];
        [self.navigationController pushViewController:contactVC animated:YES];
        
    }else if (indexPath.row == 3){
        QRCodeViewController *vc = [[QRCodeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 4){
        SafeTestViewController *vc = [[SafeTestViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        WebViewWK_VC *searchVC = [[WebViewWK_VC alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSArray *)dataArray{
    if (_dataArray==nil) {

        _dataArray = @[@"UITableView-searcSh",@"UISerachViewController",@"ContactsDemo",@"二维码",@"4.safe-dictionary-array"];
        //,@"测试三",@"测试四",@"测试三",@"测试四",@"测试三",@"测试四",@"测试三",@"测试四",@"测试三",@"测试四",@"测试三",@"测试四",@"测试三",@"测试四"
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        NSLog(@"---%@",NSStringFromCGRect(self.view.frame));
        NSLog(@"---%@",NSStringFromCGRect(_tableView.frame));
        _tableView.dataSource = self;
        _tableView.delegate = self;
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
