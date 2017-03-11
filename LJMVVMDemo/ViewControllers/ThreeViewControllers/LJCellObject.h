//
//  LJCellObject.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/10.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LJCellObjectDelegate <NSObject>

- (void)lj_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface LJCellObject : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic, copy) NSString *title;



@end
