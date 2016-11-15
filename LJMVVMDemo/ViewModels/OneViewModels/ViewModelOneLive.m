//
//  ViewModelOneLive.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModelOneLive.h"
#import "LJNetWorking.h"
#import "LiveListModel.h"
#import "LivePlayViewController.h"

@implementation ViewModelOneLive

//跳转到详情页
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController{
    LiveListModel *liveModel = model;
    LivePlayViewController *playVC = [[LivePlayViewController alloc] init];
    playVC.skipId = liveModel.skipID;
    [superController.navigationController pushViewController:playVC animated:YES];
    
}



//网络请求
- (void)getDataWithPageNum:(NSInteger)num success:(LJNetSuccessBlock)successBlock fail:(LJNetFailureBlock)failBlock{

    NSString *urlStr = [LJGlobalUrl LiveMovieUrlWithPageNum:num];
    [LJNetWorking getWithURL:urlStr Params:nil succcessBlock:^(id object) {
        
        NSArray *array = object[@"T1462958418713"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:array.count];
        for (int i = 0; i < array.count; i ++) {
            LiveListModel *model = [LiveListModel subjectWithDict:array[i]];
            [mArr addObject:model];
        }
        if (successBlock) {
            successBlock(mArr);
        }
        
    } failureBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

@end
