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

//开发的时候打印，但是发布的时候不打印的NSLog
//#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#else
//#define NSLog(...)
//#endif


//#if DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, ［NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//
//#else
//#define NSLog(FORMAT, ...) nil
//#endif



//#ifdef DEBUG
//#define LRLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#else
//#define LRLog(...)
//
//#endif

#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

#define IS_iOS9 [[UIDevice currentDevice].systemVersion floatValue] >= 9.0f
#define IS_iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f
#define IS_iOS6 [[UIDevice currentDevice].systemVersion floatValue] >= 6.0f

//NavBar高度
#define NavigationBar_HEIGHT 44

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height


//[UIScreen mainScreen].nativeScale


//获取通知中心
#define LRNotificationCenter [NSNotificationCenter defaultCenter]

//设置随机颜色
#define LRRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//设置RGB颜色/设置RGBA颜色
#define LRRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LRRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define LRClearColor [UIColor clearColor]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]


//.弱引用/强引用
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;


//设置 view 圆角和边框

#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


//由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)



//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:imageName]
//读取本地图片
#define Load_Image(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//获取当前语言
#define LRCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



//存储对象
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
//获得存储的对象
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

//     删除对象
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}



//沙盒目录文件

//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]






//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)


#endif /* Config_h */
