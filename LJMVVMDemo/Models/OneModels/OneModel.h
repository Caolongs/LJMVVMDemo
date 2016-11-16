//
//  OneModel.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LJBaseArchiverModel.h"

@class OneAdsModel;

@interface OneModel : LJBaseArchiverModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *url_3w;

@property (nonatomic, strong) NSArray<OneAdsModel *> *adsArr;

+ (id)subjectWithDict:(NSDictionary *)dict;

@end
