//
//  LJBaseModel.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/2.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJBaseArchiverModel.h"
#import <objc/runtime.h>
#import "WZLSerializeKit.h"

@implementation LJBaseArchiverModel

WZLSERIALIZE_CODER_DECODER();
WZLSERIALIZE_COPY_WITH_ZONE();
//WZLSERIALIZE_DESCRIPTION();

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
