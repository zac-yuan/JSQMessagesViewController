//
//  BBPossibleElementTests.m
//  JSQMessages
//
//  Created by Luka Bratos on 02/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BBPossibleElement.h"

@interface BBPossibleElementTests : XCTestCase

@end

@implementation BBPossibleElementTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_GivenValidRepresentation_WhenObjectIsCreated_ThenValidObjectIsReturned {
    NSDictionary *possibleElementsRepresentation = [self validRepresentation];
    BBPossibleElement *element = [[BBPossibleElement alloc] initWithDictionary:possibleElementsRepresentation];
    XCTAssertTrue(element);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

- (NSDictionary *)validRepresentation {
    return @{
             @"element_id" : @"87877",
             @"value" : @"Hey, My name is babylon. How can I help?",
             @"members": @[@{
                     @"type": @"user",
                     @"id": @"122",},
                         @{
                     @"type": @"user",
                     @"id": @"122",},
                           ],
             @"source": @{
                     @"source_type" : @"chatbot_output",
                     @"source_id" : @"null",
                 },
             @"speaker": @{
                     @"type": @"babylon",
                     @"id": @"null",
                 },
             @"possible_elements": @{
                     },
             @"expected_input":  @[@{
                     @"text"
                     }],
             @"timestamp": @"2016-06-01T10:52:29+0100",
             };
}

@end
