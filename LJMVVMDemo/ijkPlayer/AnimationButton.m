//
//  AnimationButton.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 17/3/15.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "AnimationButton.h"

@implementation AnimationButton

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [super sendAction:action to:target forEvent:event];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    [self.layer addSublayer:layer];
    
    
    
    
    UIBezierPath * pathStart = [UIBezierPath bezierPath];
    pathStart = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    
    
    
    
    UIBezierPath * pathEnd = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, -5, -5)];
    
    
    //    layer.path = pathEnd.CGPath;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)pathStart.CGPath;
    animation.toValue =  (__bridge id)pathEnd.CGPath;
    animation.duration = 0.25f;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"path"];
    
    
}
@end
