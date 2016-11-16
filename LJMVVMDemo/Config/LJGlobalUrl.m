//
//  LJGlobalUrl.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/7.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJGlobalUrl.h"

@implementation LJGlobalUrl

//今日头条的链接
+ (NSString *)OneHeadUrl{
    
    return @"http://c.m.163.com//nc/article/headline/T1348647853363/%ld-%ld.html";
}
//精选的链接
+ (NSString *)OneFeatureUrl{
    return @"http://c.m.163.com//nc/article/list/T1348649654285/%ld-%ld.html";
}

//娱乐的链接
+ (NSString *)OneRecreationUrlWithPageNum:(NSInteger)num{
    NSString *str = [NSString stringWithFormat:@"http://c.m.163.com//nc/article/list/T1348648517839/%zd-%zd.html",num*20,(num+1)*20];
    return str;
}

//直播列表的链接
+ (NSString *)LiveMovieUrlWithPageNum:(NSInteger)num{
    return [NSString stringWithFormat:@"http://c.m.163.com/nc/live/list/5LiK5rW3/%zd-%zd.html",num*20,(num+1)*20];
}

//直播详情的url
+ (NSString *)LiveDetailUrlWithSkipID:(NSString *)skipId{
    return [NSString stringWithFormat:@"http://data.live.126.net/liveAll/%@.json",skipId];
}


@end
