//
//  SBTBuilderURL.m
//  SBTProject
//
//  Created by Sergey Altukhov on 19.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTBuilderURLGraphs.h"


static NSString *const SBTFirstPartURL = @"https://api.blockchain.info/charts/";
static NSString *const SBTSecondPartURL = @"?timespan=180days&format=json";


@implementation SBTBuilderURLGraphs

+ (NSURL *)urlWithNameGraph:(NSString *)nameString
{
    if (!nameString)
    {
        return nil;
    }
    NSDictionary *nameGraphDictionary = @{@"Market Price (USD)" : @"market-price", @"USD Exchange Trade Volume" : @"trade-volume",
        @"Market Capitalization" : @"market-cap", @"Miners Revenue" : @"miners-revenue", @"Total Transaction Fees" : @"transaction-fees"};
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",SBTFirstPartURL,nameGraphDictionary[nameString], SBTSecondPartURL];
    return [NSURL URLWithString:urlString];
}

@end
