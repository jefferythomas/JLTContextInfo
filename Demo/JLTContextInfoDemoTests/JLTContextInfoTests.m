//
//  JLTContextInfoTests.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLT Source. All rights reserved.
//

#import "JLTContextInfoTests.h"
#import "NSObject+JLTContextInfo.h"

@implementation JLTContextInfoTests

- (void)testContextInfo
{
    NSObject *object = [[NSObject alloc] init];
    NSMutableDictionary *contextInfo = [object JLT_contextInfo];
    XCTAssertNotNil(contextInfo);
    XCTAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]]);
}

#if defined(JLT_SHORTHAND)
- (void)testContextInfoShorthand
{
    NSObject *object = [[NSObject alloc] init];
    NSMutableDictionary *contextInfo = [object contextInfo];
    XCTAssertNotNil(contextInfo);
    XCTAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]]);
}
#endif

- (void)testContextInfoSaveString
{
    NSObject *object = [[NSObject alloc] init];
    [[object JLT_contextInfo] setObject:@"Test String" forKey:@"saved"];

    NSString *saved = [[object JLT_contextInfo] objectForKey:@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

- (void)testContextInfoAsProperty
{
    NSObject *object = [[NSObject alloc] init];
    NSMutableDictionary *contextInfo = object.JLT_contextInfo;
    XCTAssertNotNil(contextInfo);
    XCTAssertTrue([contextInfo isKindOfClass:[NSMutableDictionary class]]);
}

- (void)testContextInfoWithSubscriptedKey
{
    NSObject *object = [[NSObject alloc] init];
    object.JLT_contextInfo[@"saved"] = @"Test String";

    NSString *saved = object.JLT_contextInfo[@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}

#if defined(JLT_SHORTHAND)
- (void)testContextInfoShorthandWithSubscriptedKey
{
    NSObject *object = [[NSObject alloc] init];
    object.contextInfo[@"saved"] = @"Test String";

    NSString *saved = object.contextInfo[@"saved"];
    XCTAssertEqualObjects(saved, @"Test String");
}
#endif

@end
