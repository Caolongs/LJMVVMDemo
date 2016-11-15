//
//  LiveListModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LiveListModel.h"

@implementation LiveListModel

+ (id)subjectWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //处理关键字 "id"...
//    if ([key isEqualToString:@"ads"]) {
//        
//    }
    
}

@end
