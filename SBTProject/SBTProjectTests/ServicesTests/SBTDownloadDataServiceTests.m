//
//  SBTDownloadDataServiceTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 10.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTDownloadDataService.h"

#import "SBTBuilderURLGraphs.h"
#import "SBTBuilderURLPrice.h"
#import "SBTBuilderURLNews.h"
#import "SBTParsingJSONGraphs.h"
#import "SBTParsingJSONPrice.h"
#import "SBTParsingJSONNews.h"


@interface SBTDownloadDataService (SBTTests)

- (NSURL *)buildURLByType:(SBTDownloadDataType)dataType urlKeyString:(NSString *)urlKey;
- (id)parsingByType:(SBTDownloadDataType)dataType json:(id)json;

@end


@interface SBTDownloadDataServiceTests : XCTestCase

@property (nonatomic, strong) SBTDownloadDataService *testDownloadDataService;

@end


@implementation SBTDownloadDataServiceTests

- (void)setUp
{
    [super setUp];
    self.testDownloadDataService = OCMPartialMock([SBTDownloadDataService new]);
}

- (void)tearDown
{
    self.testDownloadDataService = nil;
    [super tearDown];
}

- (void)testBuildURLByTypeDownloadDataTypeGraph
{
    NSURL *controlURL = [NSURL URLWithString:@"www.DownloadDataTypeGraph.com"];
    
    id classMockBuilderURLGraphs = OCMClassMock([SBTBuilderURLGraphs class]);
    OCMStub([classMockBuilderURLGraphs urlWithNameGraph:[OCMArg any]]).andReturn(controlURL);
    
    NSURL *url = [self.testDownloadDataService buildURLByType:SBTDownloadDataTypeGraph urlKeyString:@""];
    expect(url).toNot.beNil();
    expect(url).to.equal(controlURL);
    
    [classMockBuilderURLGraphs stopMocking];
}

- (void)testBuildURLByTypeDownloadDataTypePrice
{
    NSURL *controlURL = [NSURL URLWithString:@"www.DownloadDataTypePrice.com"];
    
    id classMockBuilderURLPrice = OCMClassMock([SBTBuilderURLPrice class]);
    OCMStub([classMockBuilderURLPrice urlWithNameCryptoString:[OCMArg any]]).andReturn(controlURL);
    
    NSURL *url = [self.testDownloadDataService buildURLByType:SBTDownloadDataTypePrice urlKeyString:@""];
    expect(url).toNot.beNil();
    expect(url).to.equal(controlURL);
    
    [classMockBuilderURLPrice stopMocking];
}

- (void)testBuildURLByTypeDownloadDataTypeNews
{
    NSURL *controlURL = [NSURL URLWithString:@"www.DownloadDataTypeNews.com"];
    
    id classMockBuilderURLNews = OCMClassMock([SBTBuilderURLNews class]);
    OCMStub([classMockBuilderURLNews urlWithPageSize:[OCMArg any]]).andReturn(controlURL);
    
    NSURL *url = [self.testDownloadDataService buildURLByType:SBTDownloadDataTypeNews urlKeyString:@""];
    expect(url).toNot.beNil();
    expect(url).to.equal(controlURL);
    
    [classMockBuilderURLNews stopMocking];
}

- (void)testParsingByTypeDownloadDataTypeGraph
{
    NSArray *controlArray = @[@"TypeGraph"];
    
    id classMockParsingJSONGraphs = OCMClassMock([SBTParsingJSONGraphs class]);
    OCMStub([classMockParsingJSONGraphs jsonToModel:[OCMArg any]]).andReturn(controlArray);
    
    NSArray *testArray = [self.testDownloadDataService parsingByType:SBTDownloadDataTypeGraph json:@{}];
    
    expect(testArray).toNot.beNil();
    expect(testArray.count == 1).to.beTruthy();
    expect(testArray[0]).to.equal(@"TypeGraph");
    
    [classMockParsingJSONGraphs stopMocking];
}

- (void)testParsingByTypeDownloadDataTypePrice
{
    NSArray *controlArray = @[@"TypePrice"];
    
    id classMockParsingJSONPrice = OCMClassMock([SBTParsingJSONPrice class]);
    OCMStub([classMockParsingJSONPrice jsonToModel:[OCMArg any]]).andReturn(controlArray);
    
    NSArray *testArray = [self.testDownloadDataService parsingByType:SBTDownloadDataTypePrice json:@{}];
    
    expect(testArray).toNot.beNil();
    expect(testArray.count == 1).to.beTruthy();
    expect(testArray[0]).to.equal(@"TypePrice");
    
    [classMockParsingJSONPrice stopMocking];
}

- (void)testParsingByTypeDownloadDataTypeNews
{
    NSArray *controlArray = @[@"TypeNews"];
    
    id classMockParsingJSONNews = OCMClassMock([SBTParsingJSONNews class]);
    OCMStub([classMockParsingJSONNews jsonToModel:[OCMArg any]]).andReturn(controlArray);
    
    NSArray *testArray = [self.testDownloadDataService parsingByType:SBTDownloadDataTypeNews json:@{}];
    
    expect(testArray).toNot.beNil();
    expect(testArray.count == 1).to.beTruthy();
    expect(testArray[0]).to.equal(@"TypeNews");
    
    [classMockParsingJSONNews stopMocking];
}

@end
