//
//  NSObject+Model.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)

//+ (id)objectWithDict:(NSDictionary *)dict{
//    return [[self alloc] initWithDict:dict];
//}

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
