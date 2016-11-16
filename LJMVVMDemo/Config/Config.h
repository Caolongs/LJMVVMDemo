//
//  Config.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/17.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef Config_h
#define Config_h


//定义返回请求数据的block类型
typedef void (^ReturnValueBlock)(id returnValue);
typedef void (^ErrorCodeBlock)(id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

#import "LJGlobalUrl.h"


#ifdef DEBUG
#define LJLog(xx, ...)   NSLog(xx,__VA_ARGS__)
#else

#endif

#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

#define IS_iOS9 [[UIDevice currentDevice].systemVersion floatValue] >= 9.0f
#define IS_iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f
#define IS_iOS6 [[UIDevice currentDevice].systemVersion floatValue] >= 6.0f



#endif /* Config_h */
