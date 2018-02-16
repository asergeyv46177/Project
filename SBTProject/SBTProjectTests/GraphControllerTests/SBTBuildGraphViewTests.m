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

static NSInteger const SBTValueYRoundUpFrom19k = 19000;
static NSInteger const SBTValueYRoundUpTo20k = 20000;
static NSInteger const SBTValueYRoundUpFrom21k = 21000;
static NSInteger const SBTValueYRoundUpTo25k = 25000;
static NSInteger const SBTMaxYValueForLabels = 10000;
static NSInteger const SBTRectLineSize = 100;


@interface SBTBuildGraphView (SBTTests)

@property (nonatomic, strong) UILabel *detailedLabel;
@property (nonatomic, strong) UIImageView *detailedPointImageView;

- (NSArray <UILabel *> *)labelsYAxis:(CGFloat)stepOfGrid;
- (NSInteger)roundUpValueY:(NSInteger)number;
- (void)createDetaileView:(CGRect)rect;

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
    NSInteger value = [self.testBuildGraphView  roundUpValueY:SBTValueYRoundUpFrom19k];
    
    expect(value).to.beTruthy();
    expect(value).to.equal(SBTValueYRoundUpTo20k);
}

- (void)testRoundUpValueYRoundUpTo25k
{
    NSInteger value = [self.testBuildGraphView  roundUpValueY:SBTValueYRoundUpFrom21k];
    
    expect(value).to.beTruthy();
    expect(value).to.equal(SBTValueYRoundUpTo25k);
}

- (void)testLabelsYAxis
{
    NSInteger maxYValue = SBTMaxYValueForLabels;
    OCMStub([self.testBuildGraphView roundUpValueY:0]).andReturn(maxYValue);
    NSArray <UILabel *> *labelArray = [self.testBuildGraphView labelsYAxis:0];
    
    expect(labelArray.count == 11).to.beTruthy();
    expect(labelArray[5].text).to.equal(@"5e3");
    expect([labelArray[5].font pointSize]).to.equal(12);
}

- (void)testCreateDetaileView
{
    CGRect rect = CGRectMake(0, 0, SBTRectLineSize, SBTRectLineSize);
    [self.testBuildGraphView createDetaileView:rect];
    
    expect(self.testBuildGraphView.detailedLabel).notTo.beNil();
    expect(self.testBuildGraphView.detailedLabel.textAlignment).to.equal(NSTextAlignmentCenter);
    expect(self.testBuildGraphView.detailedPointImageView).notTo.beNil();
    expect(self.testBuildGraphView.detailedPointImageView.frame).to.equal(CGRectZero);
    expect(self.testBuildGraphView.detailedPointImageView.backgroundColor).to.equal(UIColor.clearColor);
    expect(self.testBuildGraphView.detailedPointImageView.alpha).to.equal(0.0);
}

@end
