//
//  LiveDetailModel.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/30.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJBaseModel.h"

@interface LiveDetailModel : LJBaseModel

@property (nonatomic,copy) NSString *roomName;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,copy) NSString *roomDes;
@property (nonatomic,copy) NSString *liveRoomTrigger;
@property (nonatomic,copy) NSString *chatRoomTrigger;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *order;
@property (nonatomic,assign) BOOL statExist;
@property (nonatomic,strong) NSNumber *duration;
@property (nonatomic,strong) NSNumber *roomId;
@property (nonatomic,strong) NSNumber *nextPage;
@property (nonatomic,strong) NSDictionary *banner;
@property (nonatomic,strong) NSDictionary *floatLayer;
@property (nonatomic,strong) NSDictionary *chatConfig;
@property (nonatomic,strong) NSDictionary *topMessage;
@property (nonatomic,strong) NSDictionary *emojiConfig;

@property (nonatomic,strong) NSArray *commentator_lj;
@property (nonatomic,strong) NSArray *section;
@property (nonatomic,strong) NSArray *mutilVideo_lj;
@property (nonatomic,strong) NSArray *messages_lj;

@property(nonatomic, copy) NSString *liveVideoUrl;



@end


@interface Live_commentator : LJBaseModel

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *imgUrl;

@end



@interface Live_mutilVideo : LJBaseModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *isPano;
@property(nonatomic, copy) NSString *panoUrl;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *url1;
@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *vid;

@end


@interface Live_messages : LJBaseModel

@property(nonatomic, copy) NSString *Id;//id关键字
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *section;

@property(nonatomic, strong) NSDictionary *commentator;
@property(nonatomic, strong) NSDictionary *msg;
@property(nonatomic, strong) NSArray *images;

@end


