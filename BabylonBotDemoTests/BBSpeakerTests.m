//
//  BBSpeakerTests.m
//  JSQMessages
//
//  Created by Luka Bratos on 02/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BBSpeaker.h"

@interface BBSpeakerTests : XCTestCase

@end

@implementation BBSpeakerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_GivenValidRepresentation_WhenObjectIsCreated_ThenValidObjectIsReturned {
    NSDictionary *speakerRepresentation = [self validRepresentation];
    BBSpeaker *speaker = [[BBSpeaker alloc] initWithDictionary:speakerRepresentation];
    XCTAssertTrue(speaker);
    XCTAssertEqual(speaker.type, speakerRepresentation[@"type"]);
    XCTAssertEqual(speaker.speakerId, speakerRepresentation[@"id"]);
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
