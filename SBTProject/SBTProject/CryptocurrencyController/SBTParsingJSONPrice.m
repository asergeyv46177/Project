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
    NSString *stringFloatValue = json[@"price_usd"];
    dataPriceModel.priceUSDFloat = stringFloatValue.floatValue;
    stringFloatValue = json[@"percent_change_7d"];
    dataPriceModel.percentChange7dFloat = stringFloatValue.floatValue;
    stringFloatValue = json[@"percent_change_24h"];
    dataPriceModel.percentChange24hFloat = stringFloatValue.floatValue;
    return dataPriceModel;
}


@end
