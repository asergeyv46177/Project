//
//  SBTParsingJSONGraphs.m
//  SBTProject
//
//  Created by Sergey Altukhov on 18.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTParsingJSONGraphs.h"
#import "SBTDataGraphModel.h"
#import "SBTFormatterDate.h"

@implementation SBTParsingJSONGraphs


+ (SBTDataGraphModel *)jsonToModel:(NSDictionary *)json
{
    if (!json)
    {
        return nil;
    }
    
    if (![json[@"status"] isEqualToString:@"ok"])
    {
        return nil;
    }
    
    NSInteger maxYValue = 0;
    SBTDataGraphModel *graphModel = [SBTDataGraphModel new];
    graphModel.unitString = json[@"unit"];
    graphModel.descriptionString = json[@"description"];
    graphModel.nameString = json[@"name"];
    NSArray *valuesArray = json[@"values"];
    NSMutableArray *valueXYArray = [NSMutableArray new];
    for (NSDictionary <NSString *, NSString *> *valueDictionary in valuesArray)
    {
        NSDictionary *updatedValueDictionary = [NSDictionary new];
        NSInteger xValue = valueDictionary[@"x"].integerValue;
        NSInteger yValue = valueDictionary[@"y"].integerValue;
        NSString *xValueString = [SBTFormatterDate formatterDateStringWithTimeInterval:xValue];
        
        if (maxYValue < yValue)
        {
            maxYValue = yValue;
        }
        
        updatedValueDictionary = @{@"x":xValueString, @"y":[NSString stringWithFormat:@"%li", yValue]};
        [valueXYArray addObject:updatedValueDictionary];
    }
    graphModel.valuesXYArray = [valueXYArray copy];
    graphModel.maxYInteger = maxYValue;
    
    NSTimeInterval nowTime = [NSDate new].timeIntervalSince1970;
    graphModel.dateLastUpdateString = [SBTFormatterDate formatterDateStringWithTimeInterval:nowTime];
    
    return graphModel;
}


@end
