//
//  UIButton+Vertical.m
//  SaleTool
//
//  Created by SunnyZhang on 16/10/25.
//  Copyright © 2016年 rongkai. All rights reserved.
//

#import "UIButton+Vertical.h"

@implementation UIButton(Vertical)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 button 垂直居中
 */
-(void)setButtonContentVerticalCenter

{
    
    CGSize imgViewSize,titleSize,btnSize;
    
    UIEdgeInsets imageViewEdge,titleEdge;
    
    CGFloat heightSpace = 10.0f;
    
    
    
    //设置按钮内边距
    
    imgViewSize = self.imageView.bounds.size;
    
    titleSize = self.titleLabel.bounds.size;
    
    btnSize = self.bounds.size;
    
    
    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    
    [self setImageEdgeInsets:imageViewEdge];
    
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    
    [self setTitleEdgeInsets:titleEdge];
    
}

@end
