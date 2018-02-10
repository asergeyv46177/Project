//
//  SBTCryptocurrencyTableViewCellTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 06.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "SBTCryptocurrencyTableViewCell.h"


@interface SBTCryptocurrencyTableViewCell (SBTTests)

- (NSAttributedString *)attributedString:(CGFloat)valueFloat prefixString:(NSString *)prefix;

@end


@interface SBTCryptocurrencyTableViewCellTests : XCTestCase

@property (nonatomic, strong) SBTCryptocurrencyTableViewCell *testCryptocurrencyTableViewCell;

@end


@implementation SBTCryptocurrencyTableViewCellTests

- (void)setUp
{
    [super setUp];
    self.testCryptocurrencyTableViewCell = OCMPartialMock([SBTCryptocurrencyTableViewCell new]);
}

- (void)tearDown
{
    self.testCryptocurrencyTableViewCell = nil;
    [super tearDown];
}

- (void)testAttributedStringNegativeValue
{
    NSAttributedString *attributedString = [self.testCryptocurrencyTableViewCell attributedString:-1 prefixString:@"Xd: "];
    UIColor *color = [[attributedString attributesAtIndex:4 effectiveRange:nil] objectForKey:NSForegroundColorAttributeName];
    UIFont *font = [[attributedString attributesAtIndex:4 effectiveRange:nil] objectForKey:NSFontAttributeName];
    
    expect(color).notTo.beNil();
    expect(font).notTo.beNil();
    expect(color).to.equal(UIColor.redColor);
    expect(font).to.equal([UIFont fontWithName:@"Arial-BoldMT" size:15]);
}

- (void)testAttributedStringPositiveValue
{
    NSAttributedString *attributedString = [self.testCryptocurrencyTableViewCell attributedString:1 prefixString:@"Xd: "];
    UIColor *color = [[attributedString attributesAtIndex:4 effectiveRange:nil] objectForKey:NSForegroundColorAttributeName];
    
    expect(color).notTo.beNil();
    expect(color).to.equal(UIColor.greenColor);
    expect(attributedString.string).to.equal(@"Xd: 1.00%");
}

@end
