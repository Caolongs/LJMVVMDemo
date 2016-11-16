//
//  ViewModeOne2.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/2.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModeOne2.h"
#import "OneModel2.h"
#import "LJWebViewController.h"

@implementation ViewModeOne2



#pragma mark -  得到网络请求的urlString
- (NSString *)getNetUrlString{
    NSString *url = [LJGlobalUrl OneFeatureUrl];
    url = [NSString stringWithFormat:url,((self.pageNum-1)*20),(self.pageNum*20)];
    return url;
}

//*继承的重写此方法
#pragma mark -  解析数据转换成模型,可继承提取不同 ##########
- (void)parsedData:(id)response{
    NSDictionary *dict = response;
    NSDictionary *dataArr = dict[@"T1348649654285"];
    for (NSDictionary *d in dataArr) {
        OneModel2 *model = [OneModel2 objectWithDict:d];
        [self.dataArray addObject:model];
    }
}

//*继承的重写此方法
#pragma mark - 得到model名称 ##########
- (NSString *)getModelName{
    return NSStringFromClass([OneModel2 class]);
}

@end
