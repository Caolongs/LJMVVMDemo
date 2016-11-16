//
//  AFAppNetSessionManager.h
//  淘宠宝
//
//  Created by Caolongjian on 16/7/5.
//  Copyright © 2016年 ygm. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFAppNetSessionManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
