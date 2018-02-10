//
//  SBTBuildGraphViewTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 06.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTBuildGraphView.h"


@interface SBTBuildGraphView (SBTTests)

- (NSArray <UILabel *> *)labelsYAxis:(CGFloat)stepOfGrid;
- (NSInteger)roundUpValueY:(NSInteger)number;

@end


@interface SBTBuildGraphViewTests : XCTestCase

@property (nonatomic, strong) SBTBuildGraphView *testBuildGraphView;

@end


@implementation SBTBuildGraphViewTests

- (void)setUp
{
    [super setUp];
    self.testBuildGraphView = OCMPartialMock([SBTBuildGraphView new]);
}

- (void)tearDown
{
    self.testBuildGraphView = nil;
    [super tearDown];
}

- (void)testRoundUpValueYRoundUpTo0k
{
    NSInteger value = [self.testBuildGraphView  roundUpValueY:0];
    expect(value).to.beFalsy();
}

- (void)testRoundUpValueYRoundUpTo20k
{
    NSInteger value = [self.testBuildGraphView  roundUpValueY:19000];
    
    expect(value).to.beTruthy();
    expect(value).to.equal(20000);
}

- (void)testRoundUpValueYRoundUpTo25k
{
    NSInteger value = [self.testBuildGraphView  roundUpValueY:21000];
    
    expect(value).to.beTruthy();
    expect(value).to.equal(25000);
}

- (void)testLabelsYAxis
{
    NSInteger maxYValue = 10000;
    OCMStub([self.testBuildGraphView roundUpValueY:0]).andReturn(maxYValue);
    NSArray <UILabel *> *labelArray = [self.testBuildGraphView labelsYAxis:0];
    
    expect(labelArray.count == 11).to.beTruthy();
    expect(labelArray[5].text).to.equal(@"5e3");
    expect([labelArray[5].font pointSize]).to.equal(12);
}

@end
