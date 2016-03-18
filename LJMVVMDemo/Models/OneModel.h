//
//  OneModel.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *imgUrl;

+ (id)subjectWithDict:(NSDictionary *)dict;

@end
