//
//  UIImage+exchangeImp.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/10/17.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "UIImage+exchangeImp.h"
#import <objc/runtime.h>

@implementation UIImage (exchangeImp)

////method swizzle 只需要调用一次，在分类载进内存时需要调用一次
//+ (void)load{
//    Method originalMetheod = class_getClassMethod(self, @selector(imageNamed:));
//    Method ourMethod       = class_getClassMethod(self, @selector(lj_imageNamed:));
//    method_exchangeImplementations(originalMetheod, ourMethod);
//}

+ (UIImage *)lj_imageNamed:(NSString *)name{
    //判断设备是否是iOS7 以上
    BOOL isIOS7 = [[UIDevice currentDevice].systemVersion floatValue] > 7.0;
    UIImage *image = nil;
    
    //如果是，则换成支持iOS7 的图片
    if(isIOS7){
        NSString *newName = [name stringByAppendingString:@"_os7"];
        
        // 此处需要注意，因为方法实现已经交换所以如果我们想调用系统的方法需要使用我们的方法名
        image = [UIImage lj_imageNamed:newName];
    }else{
        image = [UIImage lj_imageNamed:name];
    }
    
    return image;
}

@end
