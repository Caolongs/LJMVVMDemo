//
//  LJBaseModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/2.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJBaseModel.h"

@implementation LJBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}


+ (id)subjectWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
