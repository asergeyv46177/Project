//
//  SBTParsingJSONNewsTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTParsingJSONNews.h"
#import "SBTDataNewsModel.h"


@interface SBTParsingJSONNewsTests : XCTestCase

@end


@implementation SBTParsingJSONNewsTests

- (void)testJSONToModelNilJson
{
    NSArray *modelArray = [SBTParsingJSONNews jsonToModel:nil];
    expect(modelArray).to.beNil();
}

- (void)testJSONToModelStatusNotOk
{
    NSArray *modelArray = [SBTParsingJSONNews jsonToModel:@{}];
    expect(modelArray).to.beNil();
}

- (void)testJSONToModelStatusOkEmptyJSON
{
    NSArray *modelArray = [SBTParsingJSONNews jsonToModel:@{@"status" : @"ok"}];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 0).to.beTruthy();
}

- (void)testJSONToModel
{
    NSArray *newsArray = @[@{@"publishedAt":@"12.09.2017", @"title" : @"X", @"description" : @"NEW",
        @"author" : @"Tim Cook", @"url" : @"www.apple.com"}];
    NSDictionary *jsonDictionary = @{@"status" : @"ok", @"articles" : newsArray};
    
    id objectMockDataNewsModel = OCMPartialMock([SBTDataNewsModel new]);
    id classMockDataNewsModel = OCMClassMock([SBTDataNewsModel class]);
    OCMStub([classMockDataNewsModel new]).andReturn(objectMockDataNewsModel);
    NSArray <SBTDataNewsModel *> *modelArray = [SBTParsingJSONNews jsonToModel:jsonDictionary];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 1).to.beTruthy();
    expect(modelArray[0].dateString).to.equal(@"12.09.2017");
    expect(modelArray[0].titleString).to.equal(@"X");
    expect(modelArray[0].descriptionString).to.equal(@"NEW");
    expect(modelArray[0].authorString).to.equal(@"Tim Cook");
    expect(modelArray[0].urlString).to.equal(@"www.apple.com");
    
    [classMockDataNewsModel stopMocking];
}

- (void)testJSONToModelWrongArray
{
    NSArray *newsArray = @[@{@"publshedAt":@"12.09.2017", @"titl" : @"X", @"dEscription" : @"NEW",
                             @"authors" : @"Tim Cook", @"urll" : @"www.apple.com"}];
    NSDictionary *jsonDictionary = @{@"status" : @"ok", @"articles" : newsArray};
    
    id objectMockDataNewsModel = OCMPartialMock([SBTDataNewsModel new]);
    id classMockDataNewsModel = OCMClassMock([SBTDataNewsModel class]);
    OCMStub([classMockDataNewsModel new]).andReturn(objectMockDataNewsModel);
    NSArray <SBTDataNewsModel *> *modelArray = [SBTParsingJSONNews jsonToModel:jsonDictionary];
    
    expect(modelArray).notTo.beNil();
    expect(modelArray.count == 1).to.beTruthy();
    expect(modelArray[0].dateString).to.beNil();
    expect(modelArray[0].titleString).to.beNil();
    expect(modelArray[0].descriptionString).to.beNil();
    expect(modelArray[0].authorString).to.beNil();
    expect(modelArray[0].urlString).to.beNil();
    
    [classMockDataNewsModel stopMocking];
}

@end
