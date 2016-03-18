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

#ifdef DEBUG
#define LJLog(xx, ...)   NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else

#endif


#endif /* Config_h */
