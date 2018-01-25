//
//  SBTDataPriceModel.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTDataPriceModel.h"


@implementation SBTDataPriceModel


- (void)updateModel:(SBTDataPriceModel *)dataPriceModel
{
    self.symbolString = dataPriceModel.symbolString;
    self.percentChange24hString = dataPriceModel.percentChange24hString;
    self.percentChange7dString = dataPriceModel.percentChange7dString;
    self.priceUSDString = dataPriceModel.priceUSDString;
}


@end
