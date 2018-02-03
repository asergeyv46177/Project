//
//  SBTParsingJSONNews.m
//  SBTProject
//
//  Created by Sergey Altukhov on 31.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTParsingJSONNews.h"
#import "SBTDataNewsModel.h"


@implementation SBTParsingJSONNews

+ (NSArray *)jsonToModel:(NSDictionary *)json
{
    if (!json)
    {
        return nil;
    }
    if (![json[@"status"] isEqualToString:@"ok"])
    {
        return nil;
    }
    NSMutableArray *modelArray = [NSMutableArray new];
    NSArray *newsArray = json[@"articles"];
    for (NSDictionary *newDictionary in newsArray)
    {
        SBTDataNewsModel *dataNewsModel = [SBTDataNewsModel new];
        NSString *publishedAt = [newDictionary[@"publishedAt"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        publishedAt = [publishedAt stringByReplacingOccurrencesOfString:@"Z" withString:@""];
        dataNewsModel.dateString = publishedAt;
        dataNewsModel.titleString = newDictionary[@"title"];
        dataNewsModel.descriptionString = newDictionary[@"description"];
        dataNewsModel.authorString = newDictionary[@"author"];
        dataNewsModel.urlString = newDictionary[@"url"];
        [modelArray addObject:dataNewsModel];
    }
    return [modelArray copy];
}

@end
