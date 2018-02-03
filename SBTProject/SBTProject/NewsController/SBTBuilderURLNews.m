//
//  SBTBuilderURLNews.m
//  SBTProject
//
//  Created by Sergey Altukhov on 01.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTBuilderURLNews.h"


static NSString *const SBTFirstPartURL = @"https://newsapi.org/v2/everything?sources=crypto-coins-news&pageSize=";
static NSString *const SBTSecondPartURL = @"&apiKey=11e5f62b048d4b819e388a7b5f1a74e2";


@implementation SBTBuilderURLNews

+ (NSURL *)urlWithPageSize:(NSString *)pageSize
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", SBTFirstPartURL, pageSize, SBTSecondPartURL];
    return [NSURL URLWithString:urlString];
}

@end
