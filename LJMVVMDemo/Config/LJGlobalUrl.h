//
//  LJGlobalUrl.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/7.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJGlobalUrl : NSObject


#pragma MARK - 模块一链接
/**
 *今日头条的链接
 */
+ (NSString *)OneHeadUrl;
//精选的链接
+ (NSString *)OneFeatureUrl;

//娱乐的链接
+ (NSString *)OneRecreationUrlWithPageNum:(NSInteger)num;

//直播列表的链接
+ (NSString *)LiveMovieUrlWithPageNum:(NSInteger)num;

//直播详情的url
+ (NSString *)LiveDetailUrlWithSkipID:(NSString *)skipId;

@end
