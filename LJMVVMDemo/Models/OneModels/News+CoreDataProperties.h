//
//  News+CoreDataProperties.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/8.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface News (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *url_3;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *imgsrc;
@property (nullable, nonatomic, retain) NSString *postid;
@property (nullable, nonatomic, retain) NSString *votecount;
@property (nullable, nonatomic, retain) NSString *replyCount;
@property (nullable, nonatomic, retain) NSString *ltitle;
@property (nullable, nonatomic, retain) NSString *digest;
@property (nullable, nonatomic, retain) NSString *docid;
@property (nullable, nonatomic, retain) NSString *source;
@property (nullable, nonatomic, retain) NSString *priority;
@property (nullable, nonatomic, retain) NSString *lmodify;
@property (nullable, nonatomic, retain) NSString *subtitle;
@property (nullable, nonatomic, retain) NSString *boardid;
@property (nullable, nonatomic, retain) NSString *ptime;

@end

NS_ASSUME_NONNULL_END
