//
//  SBTBuilderURLPrice.m
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTBuilderURLPrice.h"


static NSString *const SBTFirstPartURL = @"https://api.coinmarketcap.com/v1/ticker/";
static NSString *const SBTSecondPartURL = @"/?convert=USD";


@implementation SBTBuilderURLPrice


+ (NSURL *)urlWithNameCryptoString:(NSString *)nameString
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",SBTFirstPartURL,nameString,SBTSecondPartURL];
    return [NSURL URLWithString:urlString];
}


@end
