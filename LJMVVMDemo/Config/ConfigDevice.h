//
//  ConfigDevice.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 17/3/22.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#ifndef ConfigDevice_h
#define ConfigDevice_h


//判断当前的iPhone设备/系统版本

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
//这个方法不是特别靠谱
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//建议使用这个方法
#define IOS_SYSTEM_STRING [[UIDevice currentDevice] systemVersion]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))




//检查系统版本

#define SYSTEM_VERSION_EQUAL_TO(v)                  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



//判断是真机还是模拟器

// 判断是不是iOS系统，如果是iOS系统在真机和模拟器输出都是YES
#if TARGET_OS_IPHONE
#endif

#if (TARGET_IPHONE_SIMULATOR)
// 在模拟器的情况下
#else
// 在真机情况下
#endif




#endif /* ConfigDevice_h */
