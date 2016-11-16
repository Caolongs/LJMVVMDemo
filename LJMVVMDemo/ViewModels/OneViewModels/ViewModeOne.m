//
//  ViewModeOne.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModeOne.h"
#import "LJWebViewController.h"


@interface ViewModeOne ()

@end

@implementation ViewModeOne


#pragma --mark 数据请求


#pragma mark - 跳转到详情页面
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController{
    LJWebViewController *vc=  [[LJWebViewController alloc] init];
    OneModel *model2 = model;
    vc.urlString = model2.url;
    [superController.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  得到网络请求的urlString
- (NSString *)getNetUrlString{
    NSString *url = [LJGlobalUrl OneHeadUrl];
    //@"http://c.m.163.com//nc/article/headline/T1348647853363/%ld-%ld.html";
    url = [NSString stringWithFormat:url,((self.pageNum-1)*20),(self.pageNum*20)];
    return url;
}

//*继承的重写此方法
#pragma mark -  解析数据转换成模型,可继承提取不同 ##########
- (void)parsedData:(id)response{
    NSDictionary *dict = response;
    NSDictionary *dataArr = dict[@"T1348647853363"];
    for (NSDictionary *d in dataArr) {
        OneModel *model = [OneModel objectWithDict:d];
        [self.dataArray addObject:model];
    }
}

//*继承的重写此方法
#pragma mark - 得到model名称 ##########
- (NSString *)getModelName{
    return NSStringFromClass([OneModel class]);
}





@end
