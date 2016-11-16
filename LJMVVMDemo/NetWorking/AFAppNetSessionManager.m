//
//  AFAppNetSessionManager.m
//  淘宠宝
//
//  Created by Caolongjian on 16/7/5.
//  Copyright © 2016年 ygm. All rights reserved.
//

#import "AFAppNetSessionManager.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"";
@implementation AFAppNetSessionManager

+ (instancetype)sharedClient {
    static AFAppNetSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppNetSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


- (instancetype)init{
    if(self = [super init]){
//        //申明返回的结果是json类型
//        self.responseSerializer = [AFJSONResponseSerializer serializer];
//        //申明请求的数据是json类型
//        self.requestSerializer = [AFJSONRequestSerializer serializer];
//        //如果报接受类型不一致请替换一致text/html或别的
//        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    }
    return self;
}
@end
