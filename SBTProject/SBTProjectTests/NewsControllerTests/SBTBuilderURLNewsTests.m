//
//  SBTBuilderURLNewsTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTBuilderURLNews.h"


static NSString *const SBTFirstPartURL = @"https://newsapi.org/v2/everything?sources=crypto-coins-news&pageSize=";
static NSString *const SBTSecondPartURL = @"&apiKey=11e5f62b048d4b819e388a7b5f1a74e2";


@interface SBTBuilderURLNewsTests : XCTestCase

@end


@implementation SBTBuilderURLNewsTests

- (void)testURLWithPageSizeNilpageSize
{
    NSURL *url = [SBTBuilderURLNews urlWithPageSize:nil];
    expect(url).to.beNil();
}

- (void)testURLWithPageSize
{
    NSString *pageSize = @"5";
    NSURL *url = [SBTBuilderURLNews urlWithPageSize:pageSize];
    NSURL *controlURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", SBTFirstPartURL, pageSize, SBTSecondPartURL]];
    
    expect(url).notTo.beNil();
    expect(url).to.equal(controlURL);
}

@end
