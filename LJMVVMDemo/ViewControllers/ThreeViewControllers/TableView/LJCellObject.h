//
//  LJCellObject.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/10.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJCellObject : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) id objectModel;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UITableViewCellAccessoryType    accessoryType;
@property (nonatomic, strong) UIColor *backColor;

@end
