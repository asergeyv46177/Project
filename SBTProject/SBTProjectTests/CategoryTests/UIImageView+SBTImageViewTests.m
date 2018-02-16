//
//  UIImageView+SBTImageViewTests.m
//  SBTProjectTests
//
//  Created by Sergey Altukhov on 14.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta.h>
#import <OCMock.h>
#import "UIImageView+SBTImageView.h"


static CGFloat const SBTLineSizeControlView = 50.0;


@interface UIImageView (SBTTests)

+ (CGAffineTransform)sbt_createAffineTransformWithArray:(NSArray <NSNumber *> *)matrixTransform offsetT:(CGFloat)radius;
+ (void)sbt_animation:(UIImageView *)view matrixTransformArray:(NSArray *)matrixTransformArray
            nameArray:(NSArray *)nameArray positionWithScaleArray:(NSArray *)positionWithScaleArray;

@end


@interface UIImageView_SBTImageViewTests : XCTestCase

@end


@implementation UIImageView_SBTImageViewTests

- (void)testSbt_animationOnViewNilSuperview
{
    UIImageView *viewWithAnimation = [UIImageView sbt_animationOnView:nil];
    expect(viewWithAnimation).to.beNil();
}

- (void)testSbt_animationOnViewNotSuperview
{
    UIImageView *viewWithAnimation = [UIImageView sbt_animationOnView:[UIButton new]];
    expect(viewWithAnimation).to.beNil();
}

- (void)testSbt_animationOnView
{
    CGRect frame = CGRectMake(0, 0, SBTLineSizeControlView, SBTLineSizeControlView);
    UIView *controlView = [[UIView alloc] initWithFrame:frame];
    
    id classMockImageView = OCMClassMock([UIImageView class]);
    OCMStub([classMockImageView sbt_animation:[OCMArg any] matrixTransformArray:[OCMArg any] nameArray:[OCMArg any]
        positionWithScaleArray:[OCMArg any]]);
    UIImageView *viewWithAnimation = [UIImageView sbt_animationOnView:controlView];
    
    expect(viewWithAnimation).notTo.beNil();
    expect(viewWithAnimation.center).to.equal(controlView.center);
    expect(viewWithAnimation.image).to.equal([UIImage imageNamed:@"orbit"]);
    
    [classMockImageView stopMocking];
}

- (void)testSbt_createAffineTransformWithArrayNilMatrixTransform
{
    CGAffineTransform affineTransform = [UIImageView sbt_createAffineTransformWithArray:nil offsetT:0];
    
    expect(affineTransform.a).to.equal(1);
    expect(affineTransform.b).to.equal(0);
    expect(affineTransform.c).to.equal(0);
    expect(affineTransform.d).to.equal(1);
    expect(affineTransform.tx).to.equal(0);
    expect(affineTransform.ty).to.equal(0);
}

- (void)testSbt_createAffineTransformWithArrayNegetiveOffsetT
{
    CGAffineTransform affineTransform = [UIImageView sbt_createAffineTransformWithArray:@[@(1)] offsetT:-1];
    
    expect(affineTransform.a).to.equal(1);
    expect(affineTransform.b).to.equal(0);
    expect(affineTransform.c).to.equal(0);
    expect(affineTransform.d).to.equal(1);
    expect(affineTransform.tx).to.equal(0);
    expect(affineTransform.ty).to.equal(0);
}

- (void)testSbt_createAffineTransformWithArray
{
    NSArray *matrixTransformArray = @[@(2), @(1), @(1), @(2), @(1), @(1)];
    CGFloat radius = 2;
    
    CGAffineTransform affineTransform = [UIImageView sbt_createAffineTransformWithArray:matrixTransformArray offsetT:radius];
    
    expect(affineTransform.a).to.equal(2);
    expect(affineTransform.b).to.equal(1);
    expect(affineTransform.c).to.equal(1);
    expect(affineTransform.d).to.equal(2);
    expect(affineTransform.tx).to.equal(2);
    expect(affineTransform.ty).to.equal(2);
}

@end
