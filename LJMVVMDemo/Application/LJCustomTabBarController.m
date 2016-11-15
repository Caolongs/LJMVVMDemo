//
//  LJCustomTabBarController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/14.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJCustomTabBarController.h"
#import "LJGPUImageViewController.h"

@interface LJCustomTabBarController ()
{
    UIButton *_selectedBtn;
}
@end

@implementation LJCustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    
    [self createTabBarView];
    
}
- (void)createTabBarView
{
    double height = 49;
    UIView *myTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - height, self.view.frame.size.width, height)];
    myTabBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:myTabBar];
    int count = 5;
    NSArray *images = @[@"tabbar_cookbook_normal.png",@"tabbar_like_normal.png",@"tabbar_compose_button",
                        @"tabbar_lesson_normal.png",@"tabbar_mine_normal.png"];
    NSArray *selectedImages = @[@"tabbar_cookbook_hightlight",@"tabbar_like_hightlight",@"tabbar_compose_button",
                        @"tabbar_lesson_hightlight",@"tabbar_mine_hightlight"];
    NSArray *titleArr = @[@"One",@"Two",@"",@"Three",@"Four"];
    double w = self.view.frame.size.width/count;
    double h = height;
    double x = 0;
    double y = 0;
    for (int i = 0; i < count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x+i*w, y, w, h);
        [myTabBar addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i ==2) {
            [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            continue;
        }
        
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateSelected];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
        button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
        //调整上下
        button.imageEdgeInsets = UIEdgeInsetsMake(5,button.titleLabel.bounds.size.width*0.5,0,button.titleLabel.bounds.size.width*0.5);
        button.titleEdgeInsets = UIEdgeInsetsMake(49-14, -button.imageView.bounds.size.width-5, 0, 0);
        
        
        if (i==0) {
            _selectedBtn = button;
            _selectedBtn.selected = YES;
        }
    }
    
}
- (void)btnClick:(UIButton *)button
{
    long index = button.tag;
    if (index==2) {
        //中间的图标
        LJGPUImageViewController *gpuVC = [[LJGPUImageViewController alloc] initWithNibName:@"LJGPUImageViewController" bundle:nil];
        [self presentViewController:gpuVC animated:YES completion:nil];
        return;
    }
    _selectedBtn.selected = NO;
    _selectedBtn = button;
    _selectedBtn.selected = YES;
    
    if (index>2) {
        index--;
    }
    self.selectedIndex = index;
    
    
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
