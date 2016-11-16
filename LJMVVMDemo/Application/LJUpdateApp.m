//
//  LJUpdateApp.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/23.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJUpdateApp.h"
#import "HYBNetworking.h"

#define APP_URL @"http://itunes.apple.com/cn/lookup?id=1124314576"

@implementation LJUpdateApp

+ (void)checkAppVersionUpdateMessageFromViewController:(UIViewController *)viewController{
    //检测app是否有更新
    [HYBNetworking getWithUrl:APP_URL params:nil success:^(id response) {
        //具体实现为
        NSArray *arr = [response objectForKey:@"results"];
        NSDictionary *dic = [arr firstObject];
        NSString *versionStr = [dic objectForKey:@"version"];
        NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
        
        
        //NSString* buile = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];build号
        NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        if ([LJUpdateApp compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本:%@",versionStr] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            UIAlertAction *OKAction  = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了知道了");
                NSURL * url = [NSURL URLWithString:trackViewUrl];//itunesURL = trackViewUrl的内容
                [[UIApplication sharedApplication] openURL:url];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:OKAction];
            
            [viewController presentViewController:alertVC animated:YES completion:nil];
        }
        
    } fail:^(NSError *error) {
        //[LJUpdateApp checkAppVersionUpdateMessageFromViewController:viewController];
    }];
}

//比较版本的方法，在这里我用的是Version来比较的
+ (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}

@end
