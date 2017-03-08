//
//  NSMutableDictionary+Safe.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Safe)

#ifdef DEBUG

#else
+(void)load{
    Class dictCls = NSClassFromString(@"__NSDictionaryM");
    Method originalMethod = class_getInstanceMethod(dictCls, @selector(setObject:forKey:));
    Method swizzledMethod = class_getInstanceMethod(dictCls, @selector(na_setObject:forKey:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
#endif


/**
 [mDict setObject:nilObj forKey:@"ccc"];
 
 */
- (void)na_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject)
        return;
    [self na_setObject:anObject forKey:aKey];
}

@end
