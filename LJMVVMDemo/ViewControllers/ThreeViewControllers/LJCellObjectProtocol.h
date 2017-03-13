//
//  LJCellObjectProtocol.h
//  LJMVVMDemo
//
//  Created by cao longjian on 17/3/13.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LJCellObjectProtocol <NSObject>

- (void)lj_tableView:(UITableView *)tableView didSelectRowType:(NSString *)type didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
