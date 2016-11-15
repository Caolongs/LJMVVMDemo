//
//  LJGuideViewController.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/23.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJGuideViewController : UIViewController

@property(nonatomic, copy) void(^btnBlock)();

BOOL checkAppVersion(void);

@end
