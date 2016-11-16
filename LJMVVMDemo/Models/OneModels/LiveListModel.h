//
//  LiveListModel.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/29.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJBaseModel.h"

@interface LiveListModel : LJBaseModel

@property(nonatomic, copy) NSString *docid;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *TAGS;
@property(nonatomic, copy) NSString *source;
@property(nonatomic, copy) NSString *skipID;
@property(nonatomic, copy) NSString *lmodify;
@property(nonatomic, copy) NSString *imgsrc;
@property(nonatomic, copy) NSString *digest;
@property(nonatomic, copy) NSString *skipType;
@property(nonatomic, copy) NSString *ptime;
@property(nonatomic, copy) NSString *TAG;
@property(nonatomic, strong) NSNumber *imgType;
@property(nonatomic, strong) NSNumber *priority;
@property(nonatomic, strong) NSDictionary *live_info;

//直播头部滚动
@property(nonatomic, assign) BOOL hasCover;
@property(nonatomic, copy) NSString *hasHead;
@property(nonatomic, copy) NSString *hasImg;
@property(nonatomic, assign) BOOL hasIcon;

+ (id)subjectWithDict:(NSDictionary *)dict;

@end





//直播头部滚动
@interface LiveHeaderModel : LJBaseModel

@property(nonatomic, assign) BOOL hasCover;
@property(nonatomic, copy) NSString *hasHead;
@property(nonatomic, copy) NSString *hasImg;
@property(nonatomic, copy) NSString *digest;
@property(nonatomic, assign) BOOL hasIcon;
@property(nonatomic, copy) NSString *docid;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *TAGS;
@property(nonatomic, copy) NSString *lmodify;
@property(nonatomic, copy) NSString *TAG;
@property(nonatomic, copy) NSString *template_lj;//
@property(nonatomic, copy) NSString *skipID;
@property(nonatomic, copy) NSString *alias;
@property(nonatomic, copy) NSString *skipType;
@property(nonatomic, copy) NSString *cid;
@property(nonatomic, copy) NSString *source;
@property(nonatomic, copy) NSString *tname;
@property(nonatomic, copy) NSString *imgsrc;
@property(nonatomic, copy) NSString *ename;
@property(nonatomic, copy) NSString *ptime;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic, strong) NSNumber *priority;
@property(nonatomic, strong) NSNumber *hasAD;
@property(nonatomic, strong) NSNumber *imgType;
@property(nonatomic, strong) NSDictionary *live_info;

@end
