//
//  ViewModelOneLivePlayer.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/30.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModelOneLivePlayer.h"
#import "LJNetWorking.h"
#import "LiveListModel.h"
#import "LivePlayViewController.h"
#import "LiveDetailModel.h"


@interface ViewModelOneLivePlayer () 

@property(nonatomic, strong) NSArray *modelArray;

@end

@implementation ViewModelOneLivePlayer

//跳转到详情页
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController{
   
}



//网络请求
- (void)getDataWithSkipID:(NSString *)skipID success:(LJNetSuccessBlock)successBlock fail:(LJNetFailureBlock)failBlock{
    
    NSString *urlStr = [LJGlobalUrl LiveDetailUrlWithSkipID:skipID];
    [LJNetWorking getWithURL:urlStr Params:nil succcessBlock:^(id object) {
        
        NSDictionary *dict = object;
        
        LiveDetailModel *model = [LiveDetailModel subjectWithDict:dict];
        if (successBlock) {
            successBlock(@[model]);
            
            self.modelArray = @[model];
            
        }
        
        
//        NSString *liveStr = dict[@"liveVideoUrl"];
//        if (liveStr) {
//            
//        }else{
//        
//            
//            NSArray *arr = dict[@"mutilVideo"];
//            NSDictionary *dict2 = arr.firstObject?arr.firstObject:nil;
//            liveStr = dict2[@"url"];
//            
//            if (!liveStr) {
//                return ;
//            }
//            if (successBlock) {
//                successBlock(@[liveStr]);
//            }
//        }
        
        
    } failureBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}





@end
