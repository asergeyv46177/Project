//
//  SBTDataGraphModel.m
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataGraphModel.h"
#import "GraphModel+CoreDataProperties.h"


@implementation SBTDataGraphModel

- (instancetype)initWithGraphModel:(GraphModel *)graphModel
{
    self = [super init];
    if (self)
    {
        _unitString = graphModel.unitString;
        _descriptionString = graphModel.descriptionString;
        _nameString = graphModel.nameString;
        _valuesXYArray = (NSArray *) graphModel.valuesXYArray;
        _dateLastUpdateString = graphModel.dateLastUpdateString;
        _maxYInteger = graphModel.maxYInteger;
    }
    return self;
}

@end
