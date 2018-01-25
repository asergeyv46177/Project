//
//  SBTParsingJSONPrice.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTParsingJSONPrice.h"
#import "SBTDataPriceModel.h"

@implementation SBTParsingJSONPrice


+ (SBTDataPriceModel *)jsonToModel:(NSArray *)jsonArray
{
    if (!jsonArray)
    {
        return nil;
    }
    NSDictionary *json = jsonArray[0];
    if (json[@"error"])
    {
        return nil;
    }
    SBTDataPriceModel *dataPriceModel = [SBTDataPriceModel new];
    dataPriceModel.nameString = json[@"name"];
    dataPriceModel.symbolString = json[@"symbol"];
    dataPriceModel.priceUSDString = json[@"price_usd"];
    dataPriceModel.percentChange7dString = json[@"percent_change_7d"];
    dataPriceModel.percentChange24hString = json[@"percent_change_24h"];
    return dataPriceModel;
}


@end
