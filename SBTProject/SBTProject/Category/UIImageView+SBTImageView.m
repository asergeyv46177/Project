//
//  UIImageView+SBTImageView.m
//  SBTProject
//
//  Created by Sergey Altukhov on 02.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "UIImageView+SBTImageView.h"


static CGFloat const SBTOffset = 40.0;
static CGFloat const SBTWidthsRatio = 2.3;
static CGFloat const SBTHeightToWidthRatio = 1.12;

static NSUInteger const SBTNumberOfPictures = 50;


@implementation UIImageView (SBTImageView)

+ (UIImageView *)sbt_animationOnView:(UIView *)superview
{
    if (!superview)
    {
        return nil;
    }
    if (![superview isMemberOfClass:[UIView class]])
    {
        return nil;
    }
    CGRect bounds = superview.bounds;
    CGFloat sideSquare = CGRectGetWidth(bounds) - SBTOffset;
    CGRect frame = CGRectMake(0, 0, sideSquare, sideSquare);
    UIImageView *view = [[UIImageView alloc] initWithFrame:frame];
    view.center = superview.center;
    view.image = [UIImage imageNamed:@"orbit"];
    
    NSArray *positionWithScale = @[@[@(0),@(360),@(1),@(1)], @[@(180),@(540),@(1),@(1)], @[@(270),@(630),@(4),@(0.25)]];
    NSArray *matrixsTransform =@[@[@(1.1),@(0),@(1), @(1.6),@(-1.2),@(-2.1)], @[@(1.1),@(0),@(-1),@(1.6),@(-1.2),@(1.8)],
        @[@(2),@(0),@(0),@(0.9),@(0.2),@(-2)]];
    NSArray *names = @[@"bitcoin",@"litecoin",@"iota"];
    [UIImageView sbt_animation:view matrixTransformArray:matrixsTransform nameArray:names
        positionWithScaleArray:positionWithScale];
    return view;
}


+ (void)sbt_animation:(UIImageView *)view matrixTransformArray:(NSArray *)matrixTransformArray nameArray:(NSArray *)nameArray
            positionWithScaleArray:(NSArray *)positionWithScaleArray
{
    [UIImageView sbt_addEarthAnimating:view];
    
    NSInteger counter = 0;
    for (NSArray <NSNumber *> *matrixTransform in matrixTransformArray)
    {
        UIImageView *coinImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nameArray[counter]]];
        [view addSubview:coinImageView];
        
        CGRect bounds = view.bounds;
        CGFloat sideSquare = CGRectGetWidth(bounds);
        CGFloat radius = sideSquare / 4.0;
        
        CGAffineTransform affineTransform = [UIImageView sbt_createAffineTransformWithArray:matrixTransform offsetT:radius];
        
        NSArray <NSNumber *> *positionWithScale = positionWithScaleArray[counter];
        CGFloat pointStart = - positionWithScale[0].floatValue * M_PI / 180.0;
        CGFloat pointStop = - positionWithScale[1].floatValue * M_PI / 180.0;
        CGPoint centerPoint = CGPointMake(sideSquare / 2.0, sideSquare / 2.0);
        CGMutablePathRef orbit = CGPathCreateMutable();
        CGPathAddArc(orbit, &affineTransform, centerPoint.x, centerPoint.y, radius, pointStart, pointStop, YES);
        
        CAKeyframeAnimation *positionKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionKeyframeAnimation.path = orbit;
        positionKeyframeAnimation.duration = 3.0;
        
        CGFloat sideSquareFrom = sideSquare * positionWithScale[2].floatValue / 20.0;
        CGFloat sideSquareTo = sideSquare * positionWithScale[3].floatValue / 5.0;
        CGRect scaleFrom = CGRectMake(0, 0, sideSquareFrom, sideSquareFrom);
        CGRect scaleTo = CGRectMake(0, 0, sideSquareTo, sideSquareTo);
        
        CABasicAnimation *boundsBasicAnimation = [CABasicAnimation animationWithKeyPath: @"bounds"];
        boundsBasicAnimation.fromValue = @(scaleFrom);
        boundsBasicAnimation.toValue = @(scaleTo);
        boundsBasicAnimation.duration = 1.5;
        boundsBasicAnimation.autoreverses = YES;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.repeatCount = HUGE_VALF;
        animationGroup.duration = 3.0;
        animationGroup.animations = @[positionKeyframeAnimation, boundsBasicAnimation];
        [coinImageView.layer addAnimation:animationGroup forKey:nil];
        
        counter++;
        CGPathRelease(orbit);
    }
}

+ (void)sbt_addEarthAnimating:(UIView *)view
{
    CGRect bounds = view.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGFloat width = CGRectGetWidth(bounds) / SBTWidthsRatio;
    CGFloat height = width * SBTHeightToWidthRatio;
    CGRect frameEarth = CGRectMake(0, 0, width, height);
    
    UIImageView *earthImageView = [[UIImageView alloc] initWithFrame:frameEarth];
    earthImageView.image = [UIImage imageNamed:@"earth0"];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (NSInteger i = 0; i < SBTNumberOfPictures; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"earth%li", i]];
        [imageArray addObject:image];
    }
    earthImageView.animationImages = imageArray;
    earthImageView.animationRepeatCount = HUGE_VALF;
    earthImageView.animationDuration = 1.2;
    earthImageView.center = center;
    [view addSubview:earthImageView];
    [earthImageView startAnimating];
}

+ (CGAffineTransform)sbt_createAffineTransformWithArray:(NSArray <NSNumber *> *)matrixTransform offsetT:(CGFloat)radius
{
    CGAffineTransform affineTransform = CGAffineTransformIdentity;
    if (!matrixTransform || radius < 0)
    {
        return affineTransform;
    }
    affineTransform.a = matrixTransform[0].floatValue;
    affineTransform.b = matrixTransform[1].floatValue;
    affineTransform.c = matrixTransform[2].floatValue;
    affineTransform.d = matrixTransform[3].floatValue;
    affineTransform.ty = radius * matrixTransform[4].floatValue;
    affineTransform.tx = radius * matrixTransform[5].floatValue;
    return affineTransform;
}

@end
