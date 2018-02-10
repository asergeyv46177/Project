//
//  SBTFileDataService.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTFileDataService.h"
#import "SBTParsingJSONDescription.h"


@implementation SBTFileDataService

+ (NSArray *)obtainJSONWithPathForResource:(NSString *)pathForResource ofType:(NSString *)type
{
    if (!pathForResource || !type)
    {
        return nil;
    }
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:pathForResource ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data)
    {
        return nil;
    }
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [SBTParsingJSONDescription jsonToModel:json];
}

@end
