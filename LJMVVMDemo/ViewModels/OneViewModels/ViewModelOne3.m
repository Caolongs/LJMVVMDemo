//
//  ViewModel3.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/7.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "ViewModelOne3.h"
#import "LJNetWorking.h"
#import "News.h"
#import "AppDelegate.h"

@implementation ViewModelOne3

//跳转到详情页
- (void)toNextViewControllerWithOneModel:(__kindof NSObject *)model superViewController:(UIViewController *)superController{
    
}



//网络请求
- (void)getDataWithPageNum:(NSInteger)num success:(LJNetSuccessBlock)successBlock fail:(LJNetFailureBlock)failBlock{
    [self getDataWithPageNum:num success:successBlock fail:failBlock cache:nil];
}

//网络请求 - 有缓存
- (void)getDataWithPageNum:(NSInteger)num success:(LJNetSuccessBlock)successBlock fail:(LJNetFailureBlock)failBlock cache:(LJNetCacheBlock)cacheBlock{
    
    //获得CoreData缓存
    if (cacheBlock) {
        if([self getEntities]){
            cacheBlock([self getEntities]);
        }
    }
    
    NSString *urlStr = [LJGlobalUrl OneRecreationUrlWithPageNum:num];
    [LJNetWorking getWithURL:urlStr Params:nil succcessBlock:^(id object) {
        
        if(num==0){
            //删除CoreData的缓存
            [self deleteEntities];
        }
        NSArray *array = object[@"T1348648517839"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:array.count];
        for (int i = 0; i < array.count; i ++) {
            
            AppDelegate *appdelegate=  (AppDelegate*)[UIApplication sharedApplication].delegate;
            News *newModel = [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:appdelegate.managedObjectContext];
            [newModel setvalueforkeywithdictionary:array[i]];
            [appdelegate saveContext];
            [mArr addObject:newModel];
            
        }
        if (successBlock) {
            successBlock(mArr);
        }
        
        
    } failureBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

#pragma mark - PrivateMethod

//增-增加一个实体
//- (News *)addEntity{
//    
//}

//删-删除实体数据
- (void)deleteEntities{
    AppDelegate *appdelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    //查询操作
    NSFetchRequest * fetchreq =   [NSFetchRequest new];
    //设置查询表
    fetchreq.entity =  [NSEntityDescription entityForName:@"News" inManagedObjectContext:appdelegate.managedObjectContext];
    //查询所有的
    NSArray *array=  [appdelegate.managedObjectContext executeFetchRequest:fetchreq error:nil];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [appdelegate.managedObjectContext deleteObject:obj];
    }];
    
}

//查-得到实体数组
- (NSArray *)getEntities{
    AppDelegate *appdelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest * fetchreq =   [NSFetchRequest new];
    //设置查询表
    fetchreq.entity =  [NSEntityDescription entityForName:@"News" inManagedObjectContext:appdelegate.managedObjectContext];
    //查询所有的新闻
    NSArray *arrayNews=  [appdelegate.managedObjectContext executeFetchRequest:fetchreq error:nil];
    return arrayNews;
}



@end
