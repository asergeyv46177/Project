//
//  SBTParsingJSONDescriptionTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTParsingJSONDescription.h"
#import "SBTDataDescriptionModel.h"


@interface SBTParsingJSONDescriptionTests : XCTestCase

@end


@implementation SBTParsingJSONDescriptionTests

- (void)testJSONToModelNilJSON
{
    NSArray *modelArray = [SBTParsingJSONDescription jsonToModel:nil];
    expect(modelArray).to.beNil();
}

- (void)testJSONToModelEmptyJSON
{
    NSArray *modelArray = [SBTParsingJSONDescription jsonToModel:@{}];
    expect(modelArray).to.beNil();
}

- (void)testJSONToModel
{
    NSArray *coinsArray = @[@{@"Name" : @"Bitcoin", @"Symbol" : @"BTC", @"StartDate" : @"00.00.0001", @"Id" : @"-1",
        @"Algorithm" : @"XXX", @"BlockReward" : @"0.5", @"BlockTime" : @"10", @"AffiliateUrl" : @"www.apple.com",
        @"Twitter" : @"@TWITTER", @"TotalCoinSupply" : @"1000"}];
    NSDictionary *jsonDictionary = @{@"status" : @"ok", @"coinsArray" : coinsArray};
    
    id objectMockDataDescriptionModel = OCMPartialMock([SBTDataDescriptionModel new]);
    id classMockDataDescriptionModel = OCMClassMock([SBTDataDescriptionModel class]);
    OCMStub([classMockDataDescriptionModel new]).andReturn(objectMockDataDescriptionModel);
    NSArray <SBTDataDescriptionModel *> *modelArray = [SBTParsingJSONDescription jsonToModel:jsonDictionary];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 1).to.beTruthy();
    expect(modelArray[0].nameString).to.equal(@"Bitcoin");
    expect(modelArray[0].symbolString).to.equal(@"BTC");
    expect(modelArray[0].startDateString).to.equal(@"00.00.0001");
    expect(modelArray[0].idString).to.equal(@"-1");
    expect(modelArray[0].algorithmString).to.equal(@"XXX");
    expect(modelArray[0].blockRewardString).to.equal(@"0.5");
    expect(modelArray[0].blockTimeString).to.equal(@"10");
    expect(modelArray[0].affiliateUrlString).to.equal(@"www.apple.com");
    expect(modelArray[0].twitterString).to.equal(@"@TWITTER");
    expect(modelArray[0].totalCoinSupplyString).to.equal(@"1000");
    
    [classMockDataDescriptionModel stopMocking];
}

- (void)testJSONToModelWrongJSON
{
    NSArray *coinsArray = @[@{@"name" : @"Bitcoin", @"Sybol" : @"BTC", @"tartdate" : @"00.00.0001", @"idd" : @"-1",
        @"Algoritm" : @"XXX", @"BlokReward" : @"0.5", @"BlocTime" : @"10", @"AffiliateURL" : @"www.apple.com",
        @"Twiter" : @"@TWITTER", @"TotalCoin" : @"1000"}];
    NSDictionary *jsonDictionary = @{@"status" : @"ok", @"coinsArray" : coinsArray};
    
    id objectMockDataDescriptionModel = OCMPartialMock([SBTDataDescriptionModel new]);
    id classMockDataDescriptionModel = OCMClassMock([SBTDataDescriptionModel class]);
    OCMStub([classMockDataDescriptionModel new]).andReturn(objectMockDataDescriptionModel);
    NSArray <SBTDataDescriptionModel *> *modelArray = [SBTParsingJSONDescription jsonToModel:jsonDictionary];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 1).to.beTruthy();
    expect(modelArray[0].nameString).to.beNil();
    expect(modelArray[0].symbolString).to.beNil();
    expect(modelArray[0].startDateString).to.beNil();
    expect(modelArray[0].idString).to.beNil();
    expect(modelArray[0].algorithmString).to.beNil();
    expect(modelArray[0].blockRewardString).to.beNil();
    expect(modelArray[0].blockTimeString).to.beNil();
    expect(modelArray[0].affiliateUrlString).to.beNil();
    expect(modelArray[0].twitterString).to.beNil();
    expect(modelArray[0].totalCoinSupplyString).to.beNil();
    
    [classMockDataDescriptionModel stopMocking];
}

@end
