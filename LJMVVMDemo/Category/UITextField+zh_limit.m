//
//  UITextField+zh_limit.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/5/4.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import "UITextField+zh_limit.h"

@implementation UITextField (zh_limit)


- (void)textFieldDidChangeEditing{
    
        NSString *toBeString = self.text;
    
        NSString *lang = [self.textInputMode primaryLanguage];
    
        if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
    
            UITextRange *selectedRange = [self markedTextRange];
    
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
            if (!position){//非高亮
    
                if (toBeString.length > 22) {
    
                    //[ToolUtil showHUD:@"您最多可以输入22个字" duration:2];
    
                    self.text = [toBeString substringToIndex:22];
                }
            }
        }else{//中文输入法以外
    
            if (toBeString.length > 22) {
    
                //[ToolUtil showHUD:@"您最多可以输入22个字" duration:2];
    
                self.text = [toBeString substringToIndex:22];
                
            }
            
        }
    
}

@end
