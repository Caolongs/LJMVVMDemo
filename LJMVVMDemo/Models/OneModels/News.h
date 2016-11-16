//
//  News.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/8.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
-(void)setvalueforkeywithdictionary:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END

#import "News+CoreDataProperties.h"
