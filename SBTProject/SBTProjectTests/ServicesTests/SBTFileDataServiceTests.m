//
//  SBTFileDataServiceTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTFileDataService.h"
#import "SBTDataDescriptionModel.h"
#import "SBTParsingJSONDescription.h"


@interface SBTFileDataServiceTests : XCTestCase

@end


@implementation SBTFileDataServiceTests

- (void)testObtainJSONWithPathForResourceNilPathForResource
{
    NSArray *modelArray = [SBTFileDataService obtainJSONWithPathForResource:nil ofType:@"json"];
    expect(modelArray).to.beNil();
}

- (void)testObtainJSONWithPathForResourceNilType
{
    NSArray *modelArray = [SBTFileDataService obtainJSONWithPathForResource:@"cryptoJSON" ofType:nil];
    expect(modelArray).to.beNil();
}

- (void)testObtainJSONWithPathForResourceNilData
{
    id classMockData = OCMClassMock([NSData class]);
    OCMStub([classMockData dataWithContentsOfFile:[OCMArg any]]).andReturn(nil);
    
    NSArray *modelArray = [SBTFileDataService obtainJSONWithPathForResource:@"cryptoJSON" ofType:@"json"];
    expect(modelArray).to.beNil();
    
    [classMockData stopMocking];
}

- (void)testObtainJSONWithPathForResource
{
    id classMockData = OCMClassMock([NSData class]);
    id objectMockData = OCMPartialMock([NSData new]);
    OCMStub([classMockData dataWithContentsOfFile:[OCMArg any]]).andReturn(objectMockData);
    
    id testMockParsingJSONDescription = OCMClassMock([SBTParsingJSONDescription class]);
    OCMStub([testMockParsingJSONDescription jsonToModel:[OCMArg any]]).andReturn(@[]);
    
    NSArray *modelArray = [SBTFileDataService obtainJSONWithPathForResource:@"cryptoJSON" ofType:@"json"];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 0).to.beTruthy();
    
    [classMockData stopMocking];
    [testMockParsingJSONDescription stopMocking];
}

@end
