//
//  LJNetWorking.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/7.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义返回请求数据的block类型
typedef void (^successBlock)(id object);
typedef void (^failureBlock)(NSError *error);
//typedef void (^errorCodeBlock)(id errorCode);

@interface LJNetWorking : NSObject

+ (NSURLSessionDataTask *)getWithURL:(NSString *)urlString Params:(NSDictionary *)parameter succcessBlock:(successBlock)succcessBlock failureBlock:(failureBlock)failureBlock;

@end
