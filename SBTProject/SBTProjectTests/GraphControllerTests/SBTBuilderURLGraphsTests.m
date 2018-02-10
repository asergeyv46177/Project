//
//  SBTBuilderURLGraphsTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 06.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTBuilderURLGraphs.h"


static NSString *const SBTFirstPartURL = @"https://api.blockchain.info/charts/";
static NSString *const SBTSecondPartURL = @"?timespan=180days&format=json";


@interface SBTBuilderURLGraphsTests : XCTestCase

@end


@implementation SBTBuilderURLGraphsTests

- (void)testURLWithNameGraphNilNameString
{
    NSURL *url = [SBTBuilderURLGraphs urlWithNameGraph:nil];
    expect(url).to.beNil();
}

- (void)testURLWithNameGraph
{
    NSURL *url = [SBTBuilderURLGraphs urlWithNameGraph:@"Miners Revenue"];
    NSURL *controlURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@miners-revenue%@",SBTFirstPartURL, SBTSecondPartURL]];
    
    expect(url).notTo.beNil();
    expect(url).to.equal(controlURL);
}

@end
