//
//  SBTNewsTableViewCellTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 08.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import <Expecta.h>
#import "SBTNewsTableViewCell.h"


static NSString *const SBTAuthor = @"AUTHOR: ";


@interface SBTNewsTableViewCell (SBTTests)

- (NSAttributedString *)attributedString:(NSString *)authorString;

@end


@interface SBTNewsTableViewCellTests : XCTestCase

@property (nonatomic, strong) SBTNewsTableViewCell *testNewsTableViewCell;

@end


@implementation SBTNewsTableViewCellTests

- (void)setUp
{
    [super setUp];
    self.testNewsTableViewCell = OCMPartialMock([SBTNewsTableViewCell new]);
}

- (void)tearDown
{
    self.testNewsTableViewCell = nil;
    [super tearDown];
}

- (void)testAttributedStringNilAuthorString
{
    NSAttributedString *attributedString = [self.testNewsTableViewCell attributedString:nil];
    
    expect(attributedString).notTo.beNil();
    expect(attributedString.string).to.equal(SBTAuthor);
}

- (void)testAttributedString
{
    NSString *authorString = @"Tim Cook";
    NSAttributedString *attributedString = [self.testNewsTableViewCell attributedString:authorString];
    UIColor *color = [[attributedString attributesAtIndex:SBTAuthor.length effectiveRange:nil] objectForKey:NSForegroundColorAttributeName];
    UIColor *controlColor = [UIColor colorWithRed:142/255.f green:142/255.f blue:147/255.f alpha:1.0];
    
    expect(attributedString).notTo.beNil();
    expect(color).to.equal(controlColor);
    expect(attributedString.string).to.equal([NSString stringWithFormat:@"%@%@", SBTAuthor, authorString]);
}

@end
