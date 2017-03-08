//
//  NSDictionary+Safe.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSDictionary (Safe)
#ifdef DEBUG

#else
+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(na_dictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
#endif

 
/**
    NSDictionary *dict = @{@"aa": nilObj, @"bb": @"bb"};

 */
+ (instancetype)na_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    
    return [self na_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}



@end
