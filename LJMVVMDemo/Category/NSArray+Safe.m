//
//  NSArray+Safe.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

#ifdef DEBUG

#else
+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(na_arrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
#endif

/**
    NSArray *array = @[@"aa", nilObj];
 
 */
+ (instancetype)na_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    
    return [self na_arrayWithObjects:nObjects count:j];
}

@end
