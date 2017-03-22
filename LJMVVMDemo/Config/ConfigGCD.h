//
//  ConfigGCD.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 17/3/22.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#ifndef ConfigGCD_h
#define ConfigGCD_h

//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#endif /* ConfigGCD_h */
