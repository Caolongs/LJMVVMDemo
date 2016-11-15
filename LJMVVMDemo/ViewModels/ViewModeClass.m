//
//  ViewModeClass.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModeClass.h"
#import <objc/runtime.h>
#import "WZLSerializeKit.h"

@interface ViewModeClass ()



@end

@implementation ViewModeClass

#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 跳转到详情页面
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController{
//    UIViewController *vc=  [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    [superController.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 网络请求
-(void)refreshRequestIsHead:(BOOL)result WithSuccessed:(LJNetSuccessBlock)successed WithFailed:(LJNetFailureBlock)failed{
    [self refreshRequestIsHead:result WithSuccessed:successed WithFailed:failed WithCache:nil];
}
-(void)refreshRequestIsHead:(BOOL)result WithSuccessed:(LJNetSuccessBlock)successed WithFailed:(LJNetFailureBlock)failed WithCache:(LJNetCacheBlock)cache{
    if (result) {
        _pageNum = 1;
        if (cache) {//如果缓存，从本地取得数据
            [self loadSectionDataFromFile];
            if (self.dataArray.count!= 0) {
                cache(_dataArray);//回调数据以便在网络请求之前显示数据
            }
        }
    }else{
        if (_pageNum < 2) {
            _pageNum = 2;
        }
    }
    //http://c.m.163.com//nc/article/headline/T1348647853363/0-20.html
//    NSString *url = @"http://c.m.163.com//nc/article/headline/T1348647853363/%ld-%ld.html";
//    url = [NSString stringWithFormat:url,((_pageNum-1)*20),(_pageNum*20)];
    [HYBNetworking getWithUrl:[self getNetUrlString] params:nil success:^(id response) {
        if (result) {
            [self.dataArray removeAllObjects];
            //解析数据，可继承提取不同
            [self parsedData:response];
            if (cache) {
                [self saveDataToFile];//存到本地
            }
        }else{
            _pageNum++;
            //解析数据，可继承提取不同
            [self parsedData:response];
        }
        successed(_dataArray);
    } fail:^(NSError *error) {
        failed();
        
    }];
}

//*继承的重写此方法
#pragma mark -  得到网络请求的urlString
- (NSString *)getNetUrlString{
    return nil;
}

//*继承的重写此方法
#pragma mark -  解析数据转换成模型,可继承提取不同 ##########
- (void)parsedData:(id)response{
//    NSDictionary *dict = response;
//    NSDictionary *dataArr = dict[@"T1348647853363"];
//    for (NSDictionary *d in dataArr) {
//        OneModel *model = [OneModel subjectWithDict:d];
//        [self.dataArray addObject:model];
//    }
    
}
//*继承的重写此方法
#pragma mark - 得到model名称 ##########
- (NSString *)getModelName{
    return NSStringFromClass([NSObject class]);
}

#pragma mark - 缓存数据到本地
- (void)saveDataToFile{
    //清除之前的数据
    [[NSFileManager defaultManager] removeItemAtPath:[self filePath] error:nil];
    //存盘
    WZLSERIALIZE_ARCHIVE(_dataArray, [self getModelName], [self filePath]);
}

#pragma mark - 从缓存中加载数据
- (void)loadSectionDataFromFile
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
        NSMutableArray *arr = nil;
        WZLSERIALIZE_UNARCHIVE(arr, [self getModelName], [self filePath]);
        self.dataArray = arr;
    }
    
}


#pragma mark - 本地缓存文件路径
- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *archiverFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",[self getModelName]]];
    //NSLog(@"======%@",archiverFilePath);
    return archiverFilePath;
}

@end
