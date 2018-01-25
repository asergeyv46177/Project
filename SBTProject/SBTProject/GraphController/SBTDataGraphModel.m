//
//  SBTDataGraphModel.m
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataGraphModel.h"


@implementation SBTDataGraphModel


- (void)updateModel:(SBTDataGraphModel *)dataGraphModel
{
    self.nameString = dataGraphModel.nameString;
    self.descriptionString = dataGraphModel.descriptionString;
    self.unitString = dataGraphModel.unitString;
    self.valuesXYArray = dataGraphModel.valuesXYArray;
    self.maxYInteger = dataGraphModel.maxYInteger;
}


@end
