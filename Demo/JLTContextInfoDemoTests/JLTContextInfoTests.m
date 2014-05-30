//
//  JLTContextInfoTests.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLT Source. All rights reserved.
//

#import "JLTContextInfoTests.h"
#import "NSObject+JLTContextInfo.h"

#if defined(JLT_PREFIX_CATEGORIES)
#define contextInfo JLT_contextInfo
#endif

@implementation JLTContextInfoTests

- (void)testContextInfoAsMethod
{
    NSObject *object = [NSObject new];
    NSMutableDictionary *contextInfo = [object contextInfo];
    XCTAssertNotNil(contextInfo);
    XCTAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]]);
}

- (void)testContextInfoWithObjectForKey
{
    NSObject *object = [NSObject new];
    [[object contextInfo] setObject:@"Test String" forKey:@"saved"];

    NSString *saved = [[object contextInfo] objectForKey:@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

- (void)testContextInfoAsProperty
{
    NSObject *object = [NSObject new];
    NSMutableDictionary *contextInfo = object.contextInfo;
    XCTAssertNotNil(contextInfo);
    XCTAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]]);
}

- (void)testContextInfoWithSubscriptedKey
{
    NSObject *object = [NSObject new];
    object.contextInfo[@"saved"] = @"Test String";

    NSString *saved = object.contextInfo[@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

- (void)testContextInfoWithKeyValueCoding
{
    NSObject *object = [NSObject new];
    object.contextInfo[@"saved"] = @"Test String";

    NSString *saved = [object.contextInfo valueForKey:@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

- (void)testContextInfoWithKeyValueCodingKeyPath
{
    NSObject *object = [NSObject new];
    object.contextInfo[@"saved"] = @"Test String";

    NSString *saved = [object valueForKeyPath:@"contextInfo.saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

@end
