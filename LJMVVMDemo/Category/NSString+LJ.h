//
//  NSString+LJ.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/8.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LJ)

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;

@end
