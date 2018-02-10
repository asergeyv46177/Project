//
//  SBTParsingJSONGraphsTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 05.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTParsingJSONGraphs.h"
#import "SBTDataGraphModel.h"
#import "NSDate+SBTDate.h"


@interface SBTParsingJSONGraphsTests : XCTestCase

@end


@implementation SBTParsingJSONGraphsTests

- (void)testJsonToModelNilJSON
{
    SBTDataGraphModel *dataGraphModel = [SBTParsingJSONGraphs jsonToModel:nil];
    expect(dataGraphModel).to.beNil();
}

- (void)testJsonToModelStatusError
{
    SBTDataGraphModel *dataGraphModel = [SBTParsingJSONGraphs jsonToModel:@{@"status" : @"error"}];
    expect(dataGraphModel).to.beNil();
}

- (void)testJsonToModelEmptyValuesArray
{
    NSDictionary *jsonDictionary = @{@"status" : @"ok",  @"unit": @"USD", @"description" : @"descriptionGraph",
        @"name" : @"nameGraph"};
    
    id objectMockDataGraphModel = OCMPartialMock([SBTDataGraphModel new]);
    id classMockDataGraphModel = OCMClassMock([SBTDataGraphModel class]);
    OCMStub([classMockDataGraphModel new]).andReturn(objectMockDataGraphModel);
    
    id classMockDate = OCMClassMock([NSDate class]);
    OCMStub([[classMockDate ignoringNonObjectArgs] sbt_formatterDateStringWithTimeInterval:0]).andReturn(@"Jan,1");
    
    SBTDataGraphModel *dataGraphModel = [SBTParsingJSONGraphs jsonToModel:jsonDictionary];
    
    expect(dataGraphModel).notTo.beNil();
    expect(dataGraphModel.unitString).to.equal(@"USD");
    expect(dataGraphModel.descriptionString).to.equal(@"descriptionGraph");
    expect(dataGraphModel.nameString).to.equal(@"nameGraph");
    expect(dataGraphModel.dateLastUpdateString).to.equal(@"Jan,1");
    
    [classMockDataGraphModel stopMocking];
}

- (void)testJsonToModel
{
    NSDictionary *jsonDictionary = @{@"status" : @"ok", @"values" : @[@{@"x" : @(1), @"y" : @(1)}]};
    
    id objectMockDataGraphModel = OCMPartialMock([SBTDataGraphModel new]);
    id classMockDataGraphModel = OCMClassMock([SBTDataGraphModel class]);
    OCMStub([classMockDataGraphModel new]).andReturn(objectMockDataGraphModel);
    
    id classMockDate = OCMClassMock([NSDate class]);
    OCMStub([[classMockDate ignoringNonObjectArgs] sbt_formatterDateStringWithTimeInterval:0]).andReturn(@"Jan,2");
    SBTDataGraphModel *dataGraphModel = [SBTParsingJSONGraphs jsonToModel:jsonDictionary];
    
    expect(dataGraphModel).notTo.beNil();
    expect(dataGraphModel.unitString).to.beNil();
    expect(dataGraphModel.descriptionString).to.beNil();
    expect(dataGraphModel.nameString).to.beNil();
    expect(dataGraphModel.valuesXYArray.count == 1).to.beTruthy();
    expect(dataGraphModel.valuesXYArray[0][@"y"]).to.equal(@"1");
    expect(dataGraphModel.maxYInteger == 1).to.beTruthy();
    expect(dataGraphModel.dateLastUpdateString).to.equal(@"Jan,2");
    
    [classMockDataGraphModel stopMocking];
    [classMockDate stopMocking];
}

- (void)testJsonToModelWrongJSON
{
    NSDictionary *jsonDictionary = @{@"status" : @"ok",  @"unt": @"USD", @"detion" : @"descriptionGraph",
        @"nae" : @"nameGraph", @"vaues" : @[@{@"x" : @(1), @"y" : @(1)}]};
    
    id objectMockDataGraphModel = OCMPartialMock([SBTDataGraphModel new]);
    id classMockDataGraphModel = OCMClassMock([SBTDataGraphModel class]);
    OCMStub([classMockDataGraphModel new]).andReturn(objectMockDataGraphModel);
    
    id classMockDate = OCMClassMock([NSDate class]);
    OCMStub([[classMockDate ignoringNonObjectArgs] sbt_formatterDateStringWithTimeInterval:0]).andReturn(@"Jan,3");
    SBTDataGraphModel *dataGraphModel = [SBTParsingJSONGraphs jsonToModel:jsonDictionary];
    
    expect(dataGraphModel).notTo.beNil();
    expect(dataGraphModel.unitString).to.beNil();
    expect(dataGraphModel.descriptionString).to.beNil();
    expect(dataGraphModel.nameString).to.beNil();
    expect(dataGraphModel.valuesXYArray.count == 0).to.beTruthy();
    expect(dataGraphModel.maxYInteger).to.equal(0);
    expect(dataGraphModel.dateLastUpdateString).to.equal(@"Jan,3");
    
    [classMockDataGraphModel stopMocking];
    [classMockDate stopMocking];
}

@end
