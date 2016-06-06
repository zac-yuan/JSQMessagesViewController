//
//  BBMemberTests.m
//  JSQMessages
//
//  Created by Luka Bratos on 02/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BBMember.h"

@interface BBMemberTests : XCTestCase

@end

@implementation BBMemberTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_GivenValidRepresentation_WhenObjectIsCreated_ThenValidObjectIsReturned {
    NSDictionary *memberRepresentation = [self validRepresentation];
    BBMember *member = [[BBMember alloc] initWithDictionary:memberRepresentation];
    XCTAssertTrue(member);
    XCTAssertEqual(member.type, memberRepresentation[@"type"]);
    XCTAssertEqual(member.memberId, memberRepresentation[@"id"]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

- (NSDictionary *)validRepresentation {
    return @{
             @"type": @"user",
             @"id": @"122"
             };
}

@end
