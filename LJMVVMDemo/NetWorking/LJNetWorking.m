//
//  LJNetWorking.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/7.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJNetWorking.h"
#import "AFNetWorking.h"
#import "AFAppNetSessionManager.h"


@implementation LJNetWorking

#pragma --mark GET请求方式
+ (NSURLSessionDataTask *)getWithURL:(NSString *)urlString Params:(NSDictionary *)parameter succcessBlock:(successBlock)succcessBlock failureBlock:(failureBlock)failureBlock{
    
    AFAppNetSessionManager *manager = [AFAppNetSessionManager sharedClient];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSURLSessionDataTask *dataTask = [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"%lld",downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (succcessBlock) {
            succcessBlock(responseObject);
        }
        //NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"...");
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    return dataTask;
}

#pragma --mark Post请求方式
+ (void)postWithURL:(NSString *)urlString Params:(NSDictionary *)parameter succcessBlock:(successBlock)succcessBlock failureBlock:(failureBlock)failureBlock{
    
    AFAppNetSessionManager *manager = [AFAppNetSessionManager sharedClient];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"%lld",downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (succcessBlock) {
            succcessBlock(responseObject);
        }
        //NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"...");
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
