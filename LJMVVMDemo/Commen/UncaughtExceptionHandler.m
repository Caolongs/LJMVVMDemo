//
//  UncaughtExceptionHandler.m
//  ExceptionDemo
//
//  Created by Caolongjian on 16/8/16.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "UncaughtExceptionHandler.h"

#include <libkern/OSAtomic.h>
#include <execinfo.h>

//http://www.sharejs.com/codes/objectc/5882
NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount +
         UncaughtExceptionHandlerReportAddressCount;
         i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}


- (void)validateAndSaveCriticalApplicationData
{
    
}

- (void)handleException:(NSException *)exception
{
    [self validateAndSaveCriticalApplicationData];
 
    
    //提示
    [self showAlertView:exception];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);

    int n = 0;
    while (!dismissed)
    {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
        if(n++ > 1000){
            dismissed = YES;
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

#pragma mark - 弹出提示框
- (void)showAlertView:(NSException *)exception{
    
    //[exception reason]
//    [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]]
    
    //灰色背景
    UIView *backV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [[UIApplication sharedApplication].keyWindow addSubview:backV];
    //弹框
    UIView *alertV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.75, 165)];
    alertV.center = CGPointMake(backV.bounds.size.width*0.5, backV.bounds.size.height*0.5);
    alertV.backgroundColor = [UIColor whiteColor];
    [backV addSubview:alertV];
    alertV.layer.cornerRadius = 10;
    alertV.clipsToBounds = YES;
    
    //提示
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertV.bounds.size.width, 40)];
    titleLabel.center = CGPointMake(alertV.bounds.size.width*0.5, 40);
    titleLabel.text = @"抱歉，程序出现了异常";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [alertV addSubview:titleLabel];
    //描述文字
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(23,CGRectGetMaxY(titleLabel.frame), alertV.bounds.size.width-40, 40)];
    detailLabel.font = [UIFont systemFontOfSize:13];
    detailLabel.text = @"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开";
    detailLabel.numberOfLines = 0;
    [alertV addSubview:detailLabel];
    
    //取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleButton.frame = CGRectMake(0, alertV.bounds.size.height-40, alertV.bounds.size.width*0.5, 40);
    [cancleButton setTitle:@"退出" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cancleButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag = 1;
    [alertV addSubview:cancleButton];
    //确认按钮
    UIButton *ensureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    ensureButton.frame = CGRectMake(alertV.bounds.size.width*0.5, alertV.bounds.size.height-40, alertV.bounds.size.width*0.5, 40);
    [ensureButton setTitle:@"继续" forState:UIControlStateNormal];
    ensureButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    ensureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [ensureButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    ensureButton.tag = 2;
    [alertV addSubview:ensureButton];
    //按钮分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(alertV.bounds.size.width*0.5-1, alertV.bounds.size.height-40, 1, 40)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [alertV addSubview:line];
    
    
    
    
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil) message:NSLocalizedString(@"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开",nil) preferredStyle:UIAlertControllerStyleAlert];
//
//    //退出
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"退出", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        dismissed = YES;
//    }];
//    [alertC addAction:cancel];
//    
//    //确认
//    UIAlertAction *Sure = [UIAlertAction actionWithTitle:NSLocalizedString(@"继续", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"ssssssss");
//    }];
//    [alertC addAction:Sure];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
//    
//    //另一种弹出方式
//        UIViewController *controller =[UIApplication sharedApplication].keyWindow.rootViewController;
//        for (UIWindow *win in [UIApplication sharedApplication].windows.reverseObjectEnumerator) {
//            UIViewController *rootController = win.rootViewController;
//            if (rootController != nil) {
//                controller = rootController;
//                break;
//            }
//        }
//    
//        [controller presentViewController:alertC animated:YES completion:nil];

}
- (void)btnClick:(UIButton*)btn{
    if (btn.tag == 1) {
        dismissed = YES;
    }else{
        NSLog(@"...");
    }
    [btn.superview.superview removeFromSuperview];
    //NSLog(@"___++++++");
}


@end



void HandleException(NSException *exception)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo
     setObject:callStack
     forKey:UncaughtExceptionHandlerAddressesKey];
    
    [[[UncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:[exception name]
      reason:[exception reason]
      userInfo:userInfo]
     waitUntilDone:YES];
}

//信号绑定
void SignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =
    [NSMutableDictionary
     dictionaryWithObject:[NSNumber numberWithInt:signal]
     forKey:UncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    [userInfo
     setObject:callStack
     forKey:UncaughtExceptionHandlerAddressesKey];
    
    [[[UncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
      reason:
      [NSString stringWithFormat:
       NSLocalizedString(@"Signal %d was raised.", nil),
       signal]
      userInfo:
      [NSDictionary
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       forKey:UncaughtExceptionHandlerSignalKey]]
     waitUntilDone:YES];
}



void InstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
}

