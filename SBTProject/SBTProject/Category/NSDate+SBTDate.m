//
//  NSDate+SBTDate.m
//  SBTProject
//
//  Created by Sergey Altukhov on 02.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "NSDate+SBTDate.h"


@implementation NSDate (SBTDate)

+ (NSString *)sbt_formatterDateStringWithTimeInterval:(NSTimeInterval)timeInterval
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
