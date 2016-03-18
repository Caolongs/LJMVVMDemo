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

@interface ViewControllerOne () <ViewModelDelegate>

@property (nonatomic,strong) ViewModeOne *viewModel;
@property (nonatomic,strong) OneContentView *contentView;

@end

@implementation ViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.opaque = NO;
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.viewModel = [[ViewModeOne alloc] init];
    _viewModel.delegate = self;
    [_viewModel fetchOneData];
    
    
}
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



#pragma --mark ViewModelDelegate
- (void)successGetModelArray:(NSArray *)modelArray{
    
    self.contentView.OneArray = modelArray;
    NSLog(@"---%@",modelArray);
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
