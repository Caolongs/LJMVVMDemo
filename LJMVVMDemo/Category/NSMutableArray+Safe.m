//
//  NSMutableArray+Safe.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Safe)

#ifdef DEBUG

#else
+ (void)load {
    Class arrayCls = NSClassFromString(@"__NSArrayM");
    
    Method originalMethod1 = class_getInstanceMethod(arrayCls, @selector(insertObject:atIndex:));
    Method swizzledMethod1 = class_getInstanceMethod(arrayCls, @selector(na_insertObject:atIndex:));
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    
    Method originalMethod2 = class_getInstanceMethod(arrayCls, @selector(objectAtIndex:));
    Method swizzledMethod2 = class_getInstanceMethod(arrayCls, @selector(lj_objectAtIndex:));
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
    
    Method originalMethod3 = class_getInstanceMethod(arrayCls, @selector(setObject:atIndexedSubscript:));
    Method swizzledMethod3 = class_getInstanceMethod(arrayCls, @selector(lj_setObject:atIndexedSubscript:));
    method_exchangeImplementations(originalMethod3, swizzledMethod3);
    
    //暂未发现
    //    Method originalMethod2 = class_getInstanceMethod(arrayCls, @selector(setObject:atIndex:));
    //    Method swizzledMethod2 = class_getInstanceMethod(arrayCls, @selector(na_setObject:atIndex:));
    //    method_exchangeImplementations(originalMethod2, swizzledMethod2);
}
#endif


/**
    [mArray addObject:nilObj];
 */
- (void)na_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject)
        return;
    [self na_insertObject:anObject atIndex:index];
}


/**
    mArray[0]
 */
- (void)lj_objectAtIndex:(NSUInteger)index{
    if (index>=self.count) {
        return;
    }
    [self lj_objectAtIndex:index];
}

/**
    mArray[0] = nilObj;
 */
- (void)lj_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    if (!anObject) {
        return;
    }
    [self lj_setObject:anObject atIndexedSubscript:index];
}



- (void)na_setObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject)
        return;
    [self na_setObject:anObject atIndex:index];
}


@end
