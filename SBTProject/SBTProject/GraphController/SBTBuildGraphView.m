//
//  SBTBuildGraphView.m
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTBuildGraphView.h"
#import "SBTDataGraphModel.h"
#import "UIView+SBTView.h"


static CGFloat const SBTOffsetTop = 25.0;
static CGFloat const SBTWidthXLabel = 60.0;
static CGFloat const SBTOffsetYLabel = 5.0;
static CGFloat const SBTOffsetBottom = 40.0;
static CGFloat const SBTWidthYLabel = 150.0;
static CGFloat const SBTHeightYLabel = 14.0;
static CGFloat const SBTHeightXLabel = 40.0;

static NSInteger const SBTStepChange = 5;
static NSInteger const SBTNumberXLabel = 19;
static NSInteger const SBTNumberOfSegments = 10;
static NSInteger const SBTNumberOfSignificantSymbol = 2;


@interface SBTBuildGraphView ()

@property (nonatomic, strong) SBTDataGraphModel *dataGraphModel;
@property (nonatomic, strong) UIView *yAxisValuesView;
@property (nonatomic, strong) UILabel *detailedLabel;
@property (nonatomic, assign) CGFloat stepX;

@end


@implementation SBTBuildGraphView

- (instancetype)initWithDataGraphModel:(SBTDataGraphModel *)dataGraphModel withView:(UIView *)yAxisValuesView
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = UIColor.clearColor;
        _dataGraphModel = dataGraphModel;
        _yAxisValuesView = yAxisValuesView;
    }
    return self;
}


#pragma mark - Draw rect

- (void)drawRect:(CGRect)rect
{
    NSArray *valuesXYArray = self.dataGraphModel.valuesXYArray;
    NSInteger maxYInteger = self.dataGraphModel.maxYInteger;
    
    if (0 == maxYInteger)
    {
        return;
    }
    
    [self addLabelsYAxisWithGrid:rect];
    [self addLabelsXAxis:rect];
    [self createDetaileLabel:rect];
    
    CGFloat heightRect = rect.size.height;
    CGFloat widthRect = rect.size.width;
    CGFloat stepY = (heightRect - SBTOffsetBottom - SBTOffsetTop) / maxYInteger;
    CGFloat stepX =  widthRect / valuesXYArray.count;
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    NSInteger counter = 0;
    for (NSDictionary <NSString *, NSString *> *xyValue in valuesXYArray)
    {
        NSInteger yInteger = xyValue[@"y"].integerValue;

        CGFloat height = heightRect - SBTOffsetBottom - yInteger * stepY;
        CGFloat width = counter * stepX;
        CGPoint point = CGPointMake(width, height);
        
        if (rect.origin.x == width)
        {
            [bezier moveToPoint:point];
        }
        else
        {
            [bezier addLineToPoint:point];
        }
        counter++;
    }
    bezier.lineWidth = 2.f;
    bezier.lineJoinStyle = kCGLineJoinRound;
    bezier.lineCapStyle = kCGLineCapRound;
    [[UIColor colorWithRed:90/255.f green:200/255.f blue:250/255.f alpha:1] setStroke];
    [bezier stroke];
}


#pragma mark - Draw grid

- (void)addLabelsYAxisWithGrid:(CGRect)rect
{
    CGFloat heightRect = rect.size.height;
    CGFloat widthRect = rect.size.width;
    CGFloat stepOfGrid = (heightRect - SBTOffsetBottom - SBTOffsetTop) / SBTNumberOfSegments;
    
    [self nameAxisY:heightRect];
    
    NSArray *labelsYArray = [self labelsYAxis:stepOfGrid];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    NSInteger counter = 0;
    for(UILabel *label in labelsYArray)
    {
        CGFloat height = stepOfGrid*counter + SBTOffsetTop;
        CGPoint pointFrom = CGPointMake(0, height);
        [bezier moveToPoint:pointFrom];
        
        CGPoint pointTo = CGPointMake(widthRect, height);
        [bezier addLineToPoint:pointTo];
        
        [self.yAxisValuesView addSubview:label];
        counter++;
    }
    bezier.lineWidth = 1.f;
    bezier.lineCapStyle = kCGLineCapRound;
    [[UIColor colorWithWhite:0.0f alpha:0.2f] setStroke];
    [bezier stroke];
}


#pragma mark - Create labels

- (void)nameAxisY:(CGFloat)height
{
    CGFloat centerY = (height - SBTOffsetBottom - SBTOffsetTop) / 2.f;
    CGFloat centerX = SBTHeightYLabel / 2;
    CGPoint pointCenter = CGPointMake(centerX, centerY);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SBTWidthYLabel, SBTHeightYLabel)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.dataGraphModel.unitString;
    label.font = [UIFont systemFontOfSize:14];
    label.center = pointCenter;
    label.transform = CGAffineTransformMakeRotation( - M_PI_2);
    [self.yAxisValuesView addSubview:label];
}

- (void)addLabelsXAxis:(CGRect)rect
{
    
    NSArray *valuesXYArray = (NSArray *)  self.dataGraphModel.valuesXYArray;
    CGFloat heightRect = rect.size.height;
    CGFloat widthRect = rect.size.width;
    CGFloat stepX =  widthRect / valuesXYArray.count;
    
    NSInteger counter = 0;
    for (NSDictionary <NSString *, NSString *> *xyValue in valuesXYArray)
    {
        if((counter + 1) % SBTNumberXLabel == 0)
        {
            NSString *xString = xyValue[@"x"];
            CGFloat height = heightRect - SBTHeightXLabel / 2;
            CGFloat width = counter * stepX;
            CGPoint point = CGPointMake(width, height);
            CGRect rectXLabel = CGRectMake(0, 0, SBTWidthXLabel, SBTHeightXLabel);
            
            UILabel *label = [[UILabel alloc] initWithFrame:rectXLabel];
            label.center = point;
            label.text = xString;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
        }
        counter++;
    }
}

- (void)createDetaileLabel:(CGRect)rect
{
    NSArray *valuesXYArray = self.dataGraphModel.valuesXYArray;
    CGFloat widthRect = rect.size.width;
    CGFloat stepX =  widthRect / valuesXYArray.count;
    self.stepX = stepX;
    
    CGRect bounds = self.yAxisValuesView.bounds;
    CGFloat width = CGRectGetWidth(bounds);
    CGRect frame = CGRectMake(SBTOffsetYLabel * 2 + SBTHeightYLabel, 0, width, SBTHeightXLabel / 2);
    
    self.detailedLabel = [[UILabel alloc] initWithFrame:frame];
    self.detailedLabel.textAlignment = NSTextAlignmentCenter;
    [self.yAxisValuesView addSubview:self.detailedLabel];
}

- (NSArray <UILabel *> *)labelsYAxis:(CGFloat)stepOfGrid
{
    NSInteger numberOfLines = SBTNumberOfSegments + 1;
    NSInteger stepYLabel = [self roundUpValueY:self.dataGraphModel.maxYInteger] / SBTNumberOfSegments;
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    
    NSMutableArray *labelsYArray = [NSMutableArray new];
    for (NSUInteger lineNumber = 0; lineNumber < numberOfLines; lineNumber++)
    {
        CGRect bounds = self.yAxisValuesView.bounds;
        CGFloat originX = SBTOffsetYLabel * 2 + SBTHeightYLabel;
        CGFloat originY = CGRectGetMinY(bounds) + SBTOffsetYLabel + lineNumber*stepOfGrid;
        CGRect rect = CGRectMake(originX, originY, SBTWidthYLabel, SBTHeightYLabel);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        NSString *textLabel = [numberFormatter stringFromNumber:@(stepYLabel * (SBTNumberOfSegments - lineNumber))];
        label.text = [textLabel stringByReplacingOccurrencesOfString:@"E" withString:@"e"];;
        label.font = [UIFont systemFontOfSize:12];
        [labelsYArray addObject:label];
    }
    return [labelsYArray copy];
}

- (NSInteger)roundUpValueY:(NSInteger)number
{
    NSInteger countOfCharsInNumber = [NSString stringWithFormat:@"%li", number].length;
    NSInteger roundedToSecondHighestSymbol = round(number / (pow(10, countOfCharsInNumber - SBTNumberOfSignificantSymbol)));
    NSInteger additive = SBTStepChange - (roundedToSecondHighestSymbol % SBTStepChange == 0
                            ? SBTStepChange : roundedToSecondHighestSymbol % SBTStepChange);
    roundedToSecondHighestSymbol += additive;
    number = roundedToSecondHighestSymbol * pow(10, countOfCharsInNumber - SBTNumberOfSignificantSymbol);
    return number;
}


#pragma mark - Responder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    NSInteger index = touchPoint.x / self.stepX;
    NSDictionary *valueXY = self.dataGraphModel.valuesXYArray[index];
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *valueY = valueXY[@"y"];
    NSString *formatValueY = [numberFormatter stringFromNumber:@(valueY.integerValue)];
    self.detailedLabel.text = [NSString stringWithFormat:@"%@ %@, %@", formatValueY,
        self.dataGraphModel.unitString, valueXY[@"x"]];
    [UIView sbt_animationWithView:self.detailedLabel isAppear:YES completion:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [UIView sbt_animationWithView:self.detailedLabel isAppear:NO completion:nil];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [UIView sbt_animationWithView:self.detailedLabel isAppear:NO completion:nil];
}

@end
