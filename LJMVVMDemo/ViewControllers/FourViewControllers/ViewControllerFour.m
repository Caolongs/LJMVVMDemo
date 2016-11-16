//
//  ViewControllerFour.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewControllerFour.h"
#import "UITableViewCell+InitCell.h"
#import "LJCommenTitle.h"

#define NavigationBarHeight 64.0f
#define ImageHeight 200.0f

@interface ViewControllerFour () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *zoomImageView;
@property(nonatomic, strong) UISwitch *nightSwitch;

@end

@implementation ViewControllerFour

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self createHeaderView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //缺点就是在切换tabBar的时候有一个导航栏向上消失的动画.
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.delegate = nil;
}



- (void)createHeaderView{
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHeight, 0, 0, 0);
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_bg@2x.png"]];
    imgV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imgV.frame= CGRectMake(0, -ImageHeight, self.view.frame.size.width, ImageHeight);
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:imgV];
    self.zoomImageView = imgV;
    
    //设置autoresizesSubviews让子类自动布局
    imgV.autoresizesSubviews = YES;
    
    //头像
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    iconView.image = [UIImage imageNamed:@"user_defaultavatar"];
    iconView.center = CGPointMake(imgV.frame.size.width*0.5, ImageHeight-100);
    iconView.backgroundColor = [UIColor redColor];
    iconView.layer.cornerRadius = 30;
    iconView.clipsToBounds = YES;
    iconView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [imgV addSubview:iconView];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [LJCommenTitle mineTitles].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)[LJCommenTitle mineTitles][section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [LJCommenTitle mineTitles][indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[LJCommenTitle mineTitleImgs][indexPath.section][indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==2&&indexPath.row==0) {
        cell.accessoryView = self.nightSwitch;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

#pragma mark - delelgate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y+0;//NavigationBarHeight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHeight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //判断要显示的控制器是否是自己
    BOOL isShowMine = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowMine animated:YES];
}



#pragma mark - Setter&Getter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    }
    return _tableView;
}
- (UISwitch *)nightSwitch{
    if (_nightSwitch==nil) {
        _nightSwitch = [[UISwitch alloc] init];
    }
    return _nightSwitch;
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
