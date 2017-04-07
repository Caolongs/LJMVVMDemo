//
//  UserTests.m
//  LJMVVMDemo
//
//  Created by cao longjian on 17/4/7.
//  Copyright © 2017年 Caolongjian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserModel.h"

@interface UserTests : XCTestCase{
    
@private
    UserModel *user;
}
@end

@implementation UserTests

- (void)setUp {
    [super setUp];
    user = [[UserModel alloc] init];
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testExample {
    XCTAssertTrue([user isChinese:@"你好"],@"999");
    XCTAssertTrue([user isChinese:@"123你好"],@"");
    XCTAssertFalse([user isChinese:@"234"],@"");
    XCTAssertFalse([user isChinese:@"hello"],@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
