//
//  BBSourceTests.m
//  JSQMessages
//
//  Created by Luka Bratos on 02/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BBSource.h"

@interface BBSourceTests : XCTestCase

@end

@implementation BBSourceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_GivenValidRepresentation_WhenObjectIsCreated_ThenValidObjectIsReturned {
    NSDictionary *sourceRepresentation = [self validRepresentation];
    BBSource *source = [[BBSource alloc] initWithDictionary:sourceRepresentation];
    XCTAssertTrue(source);
    XCTAssertEqual(source.sourceType, sourceRepresentation[@"source_type"]);
    XCTAssertEqual(source.sourceId, [sourceRepresentation[@"source_id"] integerValue]);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

- (NSDictionary *)validRepresentation {
    return @{
             @"source_type": @"chatbot_output",
             @"source_id" : @"null"
             };
}

@end
