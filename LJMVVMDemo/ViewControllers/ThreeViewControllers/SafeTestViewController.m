//
//  SafeTestViewController.m
//  LJMVVMDemo
//
//  Created by cao longjian on 16/11/26.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "SafeTestViewController.h"

@interface SafeTestViewController ()

@end

@implementation SafeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self testDictionaryNullable];
    //[self testArrayNullable];
}



- (void)testDictionaryNullable {
    id nilObj  = nil;
    
    // 1. 此处会引起崩溃
    NSDictionary *dict = @{@"aa": nilObj, @"bb": @"bb"};
    NSLog(@"dict: %@", dict);
    
    NSMutableDictionary *mDict = [NSMutableDictionary new];
    mDict[@"aaa"] = nilObj; // 此处不会有问题
    [mDict setObject:@"bbb" forKey:@"bbb"];

    // 2. 此处会引起崩溃
    [mDict setObject:nilObj forKey:@"ccc"];
    
    NSLog(@"mDict: %@", mDict);
}



- (void)testArrayNullable {
    id nilObj  = nil;
    
    // 3. 此处会引起崩溃
    NSArray *array = @[@"aa", nilObj];
    NSLog(@"array: %@", array);
    
    
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    // 4. 此处会引起崩溃
    mArray[0] = nilObj;
    
    //崩溃
    NSLog(@"---%@",mArray[0]);
    
    // 5. 此处会引起崩溃
    [mArray addObject:nilObj];
    [mArray addObject:@"bbb"];
    NSLog(@"mArray: %@", mArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
