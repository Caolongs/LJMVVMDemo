//
//  LiveDetailModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/30.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LiveDetailModel.h"

@implementation LiveDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"commentator"]) {
        NSArray *arr = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Live_commentator *model = [Live_commentator subjectWithDict:obj];
            [arrM addObject:model];
        }];
        _commentator_lj = arrM;
    }
    
    if ([key isEqualToString:@"mutilVideo"]) {
        NSArray *arr = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Live_mutilVideo *model = [Live_mutilVideo subjectWithDict:obj];
            [arrM addObject:model];
        }];
        _mutilVideo_lj = arrM;
    }
    if ([key isEqualToString:@"messages"]) {
        NSArray *arr = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Live_messages *model = [Live_messages subjectWithDict:obj];
            [arrM addObject:model];
        }];
        _messages_lj = arrM;
    }

}

@end

@implementation Live_commentator

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end


@implementation Live_mutilVideo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation Live_messages

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _Id = value;
    }
}

@end



