//
//  News.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/9/8.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "News.h"

@implementation News

// Insert code here to add functionality to your managed object subclass
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(void)setvalueforkeywithdictionary:(NSDictionary*)dict{
    
    for (NSString * key in [dict allKeys]) {
        [self setValue:[dict objectForKey:key] forKey:key];
    }
}

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",[(NSNumber *)value stringValue]] forKey:key];
    }else if ([value isKindOfClass:[NSNull class]]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
        
    }else{
        
        [super setValue:value forKey:key];
        
    }
    
}
@end
