//
//  SBTFormatterDate.m
//  SBTProject
//
//  Created by Sergey Altukhov on 28.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTFormatterDate.h"


@implementation SBTFormatterDate


+ (NSString *)formatterDateStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    if (!timeInterval)
    {
        return @"";
    }
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"MMM,d";
    return [dateFormatter stringFromDate:date];
}


@end
