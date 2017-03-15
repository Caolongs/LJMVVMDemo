//
//  LJCellObjectProtocol.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LJCellObjectProtocol <NSObject>

@optional
- (void)lj_tableView:(UITableView *)tableView didSelectRowObject:(id)obj didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)lj_cellActionObj:(id)obj type:(NSString *)type atIndexPath:(NSIndexPath *)indexPath;

@end
