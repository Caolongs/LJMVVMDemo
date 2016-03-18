//
//  NetRequestClass.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/17.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NetRequestClass.h"
#import "AFNetWorking.h"

@implementation NetRequestClass

#pragma --mark 监测网络的可连接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *)strUrl{
    
    __block BOOL netState = NO;
    
    //NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    
    
    return  netState;
}

#pragma --mark GET请求方式
+ (void)netRequestGETWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter WithReturnValueBlock:(ReturnValueBlock)block WithErrorCodeBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailureBlock)failureBlock{

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        LJLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LJLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LJLog(@"...");
    }];
    
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    
    
    
    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//    }];
//    [dataTask resume];
//
}

#pragma --maek POST请求方式
+ (void)netRequestPostWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter WithReturnValueBlock:(ReturnValueBlock)block WithErrorCodeBlock:(ErrorCodeBlock)errorBlock WithFailureBlock:(FailureBlock)failureBlock{
    
}

@end
