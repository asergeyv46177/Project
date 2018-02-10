//
//  SBTCoreDataDownloadFacadeTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 07.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTCoreDataDownloadFacade.h"
#import "SBTCoreDataService.h"
#import "SBTDownloadDataService.h"
#import "SBTDataGraphModel.h"


@interface SBTCoreDataDownloadFacade (SBTTests)

@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;

@end


@interface SBTCoreDataDownloadFacadeTests : XCTestCase

@property (nonatomic, strong) SBTCoreDataDownloadFacade *testCoreDataDownloadFacade;

@end


@implementation SBTCoreDataDownloadFacadeTests

- (void)setUp
{
    [super setUp];
    self.testCoreDataDownloadFacade = OCMPartialMock([SBTCoreDataDownloadFacade new]);
}

- (void)tearDown
{
    [super tearDown];
    self.testCoreDataDownloadFacade = nil;
}

- (void)testObtainModelGraphWithPredicateStringYesRelevant
{
    id mockCoreData = OCMClassMock([SBTCoreDataService class]);
    OCMStub(self.testCoreDataDownloadFacade.coreDataService).andReturn(mockCoreData);
    OCMStub([mockCoreData obtainModelArrayWithEntityName:nil predicateString:nil]).andReturn(@[]);
    OCMStub([mockCoreData relevantGraphModel:nil]).andReturn(YES);
    
    id objectMockDataModel = OCMPartialMock([SBTDataGraphModel new]);
    id classMockDataModel = OCMClassMock([SBTDataGraphModel class]);
    OCMStub([[classMockDataModel alloc] initWithGraphModel:nil]).andReturn(objectMockDataModel);
    
    void(^completeHandler)(SBTDataGraphModel *dataGraphModel) = ^(SBTDataGraphModel *dataGraphModel){};
    [self.testCoreDataDownloadFacade obtainModelGraphWithPredicateString:nil completeHandler:completeHandler];
    
    expect(completeHandler).notTo.raiseAny();
    
    [mockCoreData stopMocking];
    [classMockDataModel stopMocking];
}

- (void)testObtainModelGraphWithPredicateStringNoRelevant
{
    id mockCoreData = OCMClassMock([SBTCoreDataService class]);
    OCMStub(self.testCoreDataDownloadFacade.coreDataService).andReturn(mockCoreData);
    OCMStub([mockCoreData obtainModelArrayWithEntityName:nil predicateString:nil]).andReturn(@[]);
    OCMStub([mockCoreData relevantGraphModel:nil]).andReturn(NO);

    id objectMockDataPriceModel = OCMPartialMock([SBTDataGraphModel new]);
    id mockDownloadData = OCMClassMock([SBTDownloadDataService class]);
    OCMStub(self.testCoreDataDownloadFacade.downloadDataService).andReturn(mockDownloadData);
    
    OCMExpect([[mockDownloadData ignoringNonObjectArgs] downloadDataWithURLKeyString:nil downloadDataType:0 queue:nil
        completeHandler:([OCMArg invokeBlockWithArgs:objectMockDataPriceModel, nil])]);
    
    void(^completeHandler)(SBTDataGraphModel *dataGraphModel) = ^(SBTDataGraphModel *dataGraphModel){};
    [self.testCoreDataDownloadFacade obtainModelGraphWithPredicateString:nil completeHandler:completeHandler];

    OCMVerifyAll(mockDownloadData);
}

@end
