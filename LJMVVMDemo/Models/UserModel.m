//
//  UserModel.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/7.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (BOOL)isChinese:(NSString *)string {
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
