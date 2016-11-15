//
//  UIImage+LJ.h
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/30.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJ)

/**
 *  颜色->图片
 *
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  给UIImage添加生成圆角图片的扩展API
 *
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

@end
