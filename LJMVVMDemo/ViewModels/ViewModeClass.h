//
//  ViewModeClass.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/3/18.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYBNetworking.h"

@protocol ViewModelDelegate <NSObject>

- (void)successGetModelArray:(NSArray *)modelArray;

@end

@interface ViewModeClass : NSObject

@property (nonatomic,weak) id<ViewModelDelegate> delegate;


@end
