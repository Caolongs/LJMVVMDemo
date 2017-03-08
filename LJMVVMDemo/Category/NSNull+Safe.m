//
//  NSNull+Safe.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "NSNull+Safe.h"

@implementation NSNull (Safe)
#ifdef DEBUG

#else
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *signature = [super methodSignatureForSelector:sel];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:@encode(void)];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
}
#endif

@end
