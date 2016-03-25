//
//  NetRequestClass.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/17.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestClass : NSObject

#pragma 监测网络的可连接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *)strUrl;

#pragma  POST请求
+ (void)netRequestPostWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter WithReturnValueBlock:(ReturnValueBlock)block WithErrorCodeBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailureBlock) failureBlock;

#pragma GET请求
+ (void)netRequestGETWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter WithReturnValueBlock:(ReturnValueBlock)block WithErrorCodeBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailureBlock)failureBlock;

@end
