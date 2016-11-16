//
//  ViewModeClass.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYBNetworking.h"

typedef void (^LJNetSuccessBlock) (NSArray *modelArray);
typedef void (^LJNetFailureBlock)();
typedef void (^LJNetCacheBlock) (NSArray *modelArray);

@interface ViewModeClass : NSObject

@property (assign,nonatomic)NSInteger pageNum;
@property(nonatomic, strong) NSMutableArray *dataArray;

//跳转到详情页
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController;

//网络请求
-(void)refreshRequestIsHead:(BOOL)result WithSuccessed:(LJNetSuccessBlock)successed WithFailed:(LJNetFailureBlock)failed ;

//网络请求-带缓存
-(void)refreshRequestIsHead:(BOOL)result WithSuccessed:(LJNetSuccessBlock)successed WithFailed:(LJNetFailureBlock)failed WithCache:(LJNetCacheBlock)cache;



#pragma mark -  解析数据转换成模型,可继承提取不同 ##########
- (void)parsedData:(id)response;
#pragma mark - 得到model名称 ##########
- (NSString *)getModelName;

@end
