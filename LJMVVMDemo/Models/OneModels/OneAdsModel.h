//
//  OneAdsModel.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJBaseArchiverModel.h"

@interface OneAdsModel : LJBaseArchiverModel

@property(nonatomic, copy) NSString *docid;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *tag;
@property(nonatomic, copy) NSString *imgsrc;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *url;

+ (id)subjectWithDict:(NSDictionary *)dict;

@end
