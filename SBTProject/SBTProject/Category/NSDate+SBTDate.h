//
//  NSDate+SBTDate.h
//  SBTProject
//
//  Created by Sergey Altukhov on 02.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Категория класса NSDate
 */
@interface NSDate (SBTDate)

/**
 Обеспечивает форматирование даты
 @param timeInterval - время в Unix-time формате
 @return строка с датой в нужном формате
 */
+ (NSString *)sbt_formatterDateStringWithTimeInterval:(NSTimeInterval)timeInterval;

@end
