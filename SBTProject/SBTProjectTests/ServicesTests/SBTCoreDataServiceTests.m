//
//  SBTCoreDataServiceTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTCoreDataService.h"
#import "NSDate+SBTDate.h"


@interface SBTCoreDataServiceTests : XCTestCase

@property (nonatomic, strong) SBTCoreDataService *testCoreDataService;

@end


@implementation SBTCoreDataServiceTests

- (void)setUp
{
    [super setUp];
    self.testCoreDataService = OCMPartialMock([SBTCoreDataService new]);
}

- (void)tearDown
{
    self.testCoreDataService = nil;
    [super tearDown];
}

- (void)testRelevantGraphModelNilDateLastUpdate
{
    BOOL isRelevant = [self.testCoreDataService relevantGraphModel:nil];
    expect(isRelevant).to.beFalsy();
}

- (void)testRelevantGraphModelObsoleteDateLastUpdate
{
    id classMockDate = OCMClassMock([NSDate class]);
    OCMStub([[classMockDate ignoringNonObjectArgs] sbt_formatterDateStringWithTimeInterval:0]).andReturn(@"Jan,2");
    
    BOOL isRelevant = [self.testCoreDataService relevantGraphModel:@"Jan,1"];
    expect(isRelevant).to.beFalsy();
    
    [classMockDate stopMocking];
}

- (void)testRelevantGraphModel
{
    id classMockDate = OCMClassMock([NSDate class]);
    OCMStub([[classMockDate ignoringNonObjectArgs] sbt_formatterDateStringWithTimeInterval:0]).andReturn(@"Jan,1");
    
    BOOL isRelevant = [self.testCoreDataService relevantGraphModel:@"Jan,1"];
    expect(isRelevant).to.beTruthy();
    
    [classMockDate stopMocking];
}

@end
