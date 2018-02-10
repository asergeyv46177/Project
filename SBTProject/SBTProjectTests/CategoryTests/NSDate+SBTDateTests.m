//
//  NSDate+SBTDateTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "NSDate+SBTDate.h"

@interface NSDate_SBTDateTests : XCTestCase

@end


@implementation NSDate_SBTDateTests

- (void)testSBT_formatterDateStringWithTimeIntervalNegativeTimeInterval
{
    NSString *timeString = [NSDate sbt_formatterDateStringWithTimeInterval:-1];
    expect(timeString).to.beNil();
}

- (void)testSBT_formatterDateStringWithTimeInterval
{
    NSString *timeString = [NSDate sbt_formatterDateStringWithTimeInterval:0];
    
    expect(timeString).notTo.beNil();
    expect(timeString).to.equal(@"Jan,1");
}

@end
