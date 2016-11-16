//
//  OneModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneModel.h"
#import "OneAdsModel.h"



@implementation OneModel



+ (id)subjectWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //处理关键字 "id"...
    
//    if ([@"imgs" isEqualToString:key]) {
//        NSArray *arr = value;
//        self.imgsrc = arr.firstObject ? arr.firstObject[@"urlSource"] : nil;
//    }
    if ([key isEqualToString:@"ads"]) {
        NSArray *arr = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            OneAdsModel *model = [OneAdsModel subjectWithDict:dic];
            [arrM addObject:model];
        }];
        self.adsArr = arrM;
    }
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"title -  , image - %@",_imgsrc];
}


@end
