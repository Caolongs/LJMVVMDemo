//
//  ViewModeOne.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModeOne.h"

@implementation ViewModeOne

#pragma --mark 数据请求
- (void)fetchOneData{
    //通常放在appdelegate
    [HYBNetworking updateBaseUrl:@"http://www.vlbuilding.com"];
    [HYBNetworking enableInterfaceDebug:YES];
    
    NSString *url = @"/ajax/mobile/searchCategroyContentList.json";
    NSDictionary *params = @{@"pageNum" : @(0),
                             @"pageSize" : @(10),
                             @"cateId" : @(1)};
    
    [HYBNetworking getWithUrl:url params:params success:^(id response) {
        [self parsedData:response];
        
    } fail:^(NSError *error) {
        LJLog(@"数据请求失败");
    }];
}

//解析数据转换成模型
- (void)parsedData:(id)response{
    NSDictionary *dict = response;
    NSDictionary *dataArr = dict[@"data"];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:15];
    for (NSDictionary *d in dataArr) {
        OneModel *model = [OneModel subjectWithDict:d];
        [mArray addObject:model];
    }
    
    if ([self.delegate respondsToSelector:@selector(successGetModelArray:)]) {
        [self.delegate successGetModelArray:mArray];
    }
}


#pragma --mark 跳转到详情页面
- (void)OneDetaiWithOneModel:(OneModel *)model withViewController:(UIViewController *)superController{

}

@end
