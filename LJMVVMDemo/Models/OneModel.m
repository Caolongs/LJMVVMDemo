//
//  OneModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "OneModel.h"
#import "NSObject+Model.h"

@implementation OneModel

+ (id)subjectWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //处理关键字 "id"...
    
    if ([@"imgs" isEqualToString:key]) {
        NSArray *arr = value;
        self.imgUrl = arr.firstObject ? arr.firstObject[@"urlSource"] : nil;
    }
    
    
}

- (NSString *)description{
    return [NSString stringWithFormat:@"title -  , image - %@",_imgUrl];
}


@end
