//
//  SBTBuilderURLPriceTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 06.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTBuilderURLPrice.h"


static NSString *const SBTFirstPartURL = @"https://api.coinmarketcap.com/v1/ticker/";
static NSString *const SBTSecondPartURL = @"/?convert=USD";


@interface SBTBuilderURLPriceTests : XCTestCase

@end


@implementation SBTBuilderURLPriceTests

- (void)testURLWithNameCryptoStringNilnNameString
{
    NSURL *url = [SBTBuilderURLPrice urlWithNameCryptoString:nil];
    expect(url).to.beNil();
}

- (void)testURLWithNameCryptoString
{
    NSString *nameCrypto = @"Bitcoin";
    NSURL *url = [SBTBuilderURLPrice urlWithNameCryptoString:nameCrypto];
    NSURL *controlURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",SBTFirstPartURL, nameCrypto, SBTSecondPartURL]];
    
    expect(url).notTo.beNil();
    expect(url).to.equal(controlURL);
}

@end
