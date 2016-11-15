//
//  ViewModelOneLivePlayer.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/30.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LJNetSuccessBlock) (NSArray *modelArray);
typedef void (^LJNetFailureBlock)(NSError *error);
typedef void (^LJNetCacheBlock) (NSArray *modelArray);

@interface ViewModelOneLivePlayer : NSObject 

//跳转到详情页
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController;

//网络请求
- (void)getDataWithSkipID:(NSString *)skipID success:(LJNetSuccessBlock)successBlock fail:(LJNetFailureBlock)failBlock;


@end
