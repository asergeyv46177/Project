//
//  SBTParsingJSONDescription.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTParsingJSONDescription.h"
#import "SBTDataDescriptionModel.h"


@implementation SBTParsingJSONDescription

+ (NSArray *)jsonToModel:(NSDictionary *)json
{
    if (!json)
    {
        return nil;
    }
    NSString *status = json[@"status"];
    if (![status isEqualToString:@"ok"])
    {
        return nil;
    }
    NSArray *coinsArray = json[@"coinsArray"];
    NSMutableArray <SBTDataDescriptionModel *> *modelArray = [NSMutableArray new];
    for (NSDictionary *modelDictionary in coinsArray)
    {
        SBTDataDescriptionModel *dataDescriptionModel = [SBTDataDescriptionModel new];
        dataDescriptionModel.nameString = modelDictionary[@"Name"];
        dataDescriptionModel.symbolString = modelDictionary[@"Symbol"];
        dataDescriptionModel.startDateString = modelDictionary[@"StartDate"];
        dataDescriptionModel.idString = modelDictionary[@"Id"];
        dataDescriptionModel.algorithmString = modelDictionary[@"Algorithm"];
        dataDescriptionModel.blockRewardString = modelDictionary[@"BlockReward"];
        dataDescriptionModel.blockTimeString = modelDictionary[@"BlockTime"];
        dataDescriptionModel.affiliateUrlString = modelDictionary[@"AffiliateUrl"];
        dataDescriptionModel.twitterString = modelDictionary[@"Twitter"];
        dataDescriptionModel.totalCoinSupplyString = modelDictionary[@"TotalCoinSupply"];
        [modelArray addObject:dataDescriptionModel];
    }
    return [modelArray copy];
}

@end
