//
//  SBTParsingJSONPriceTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 06.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTParsingJSONPrice.h"
#import "SBTDataPriceModel.h"


@interface SBTParsingJSONPriceTests : XCTestCase

@end


@implementation SBTParsingJSONPriceTests

- (void)testJSONToModelNilJSONArray
{
    SBTDataPriceModel *dataPriceModel = [SBTParsingJSONPrice jsonToModel:nil];
    expect(dataPriceModel).to.beNil();
}

- (void)testJSONToModelEmptyJSONArray
{
    SBTDataPriceModel *dataPriceModel = [SBTParsingJSONPrice jsonToModel:@[]];
    expect(dataPriceModel).to.beNil();
}

- (void)testJSONToModelStatusError
{
    NSArray *jsonArray = @[@{@"error" : @"not found"}];
    SBTDataPriceModel *dataPriceModel = [SBTParsingJSONPrice jsonToModel:jsonArray];
    
    expect(dataPriceModel).to.beNil();
}

- (void)testJSONToModel
{
    NSArray *jsonArray = @[@{@"name" : @"Bitcoin", @"symbol" : @"BTC", @"price_usd" : @"2",
        @"percent_change_7d" : @"-1", @"percent_change_24h" : @"1"}];
    
    id objectMockDataPriceModel = OCMPartialMock([SBTDataPriceModel new]);
    id classMockDataPriceModel = OCMClassMock([SBTDataPriceModel class]);
    OCMStub([classMockDataPriceModel new]).andReturn(objectMockDataPriceModel);
    SBTDataPriceModel *dataPriceModel = [SBTParsingJSONPrice jsonToModel:jsonArray];
    
    expect(dataPriceModel).notTo.beNil();
    expect(dataPriceModel.nameString).to.equal(@"Bitcoin");
    expect(dataPriceModel.symbolString).to.equal(@"BTC");
    expect(dataPriceModel.priceUSDFloat).to.equal(2);
    expect(dataPriceModel.percentChange7dFloat).to.equal(-1);
    expect(dataPriceModel.percentChange24hFloat).to.equal(1);
    
    [classMockDataPriceModel stopMocking];
}

- (void)testJSONToModelWrongJSONArray
{
    NSArray *jsonArray = @[@{@"nae" : @"Bitcoin", @"sbol" : @"BTC", @"priceusd" : @"0",
        @"percent_change_17d" : @"-1", @"percent_change_4h" : @"1"}];
    
    id objectMockDataPriceModel = OCMPartialMock([SBTDataPriceModel new]);
    id classMockDataPriceModel = OCMClassMock([SBTDataPriceModel class]);
    OCMStub([classMockDataPriceModel new]).andReturn(objectMockDataPriceModel);
    SBTDataPriceModel *dataPriceModel = [SBTParsingJSONPrice jsonToModel:jsonArray];
    
    expect(dataPriceModel).notTo.beNil();
    expect(dataPriceModel.nameString).to.beNil();
    expect(dataPriceModel.symbolString).to.beNil();
    expect(dataPriceModel.priceUSDFloat).to.equal(0);
    expect(dataPriceModel.percentChange7dFloat).to.equal(0);
    expect(dataPriceModel.percentChange24hFloat).to.equal(0);
    
    [classMockDataPriceModel stopMocking];
}

@end
