//
//  UserModel.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/7.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
/**
 *  判断字符串中是否有中文
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isChinese:(NSString *)string;

@end
