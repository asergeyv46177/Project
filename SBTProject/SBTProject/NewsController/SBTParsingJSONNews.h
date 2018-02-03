//
//  SBTParsingJSONNews.h
//  SBTProject
//
//  Created by Sergey Altukhov on 31.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataNewsModel;


/**
 Класс для получения модели SBTDataNewsModel из JSON
 */
@interface SBTParsingJSONNews : NSObject

/**
 Обеспечивает парсинг JSON в модель
 @param json - JSON, который парсится в модель
 @return массив моделей
 */
+ (NSArray *)jsonToModel:(NSDictionary *)json;

@end
