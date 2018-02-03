//
//  SBTParsingJSONDescription.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataDescriptionModel;


/**
 Класс для получения модели SBTDataDescriptionModel из JSON
 */
@interface SBTParsingJSONDescription : NSObject

/**
 Обеспечивает парсинг JSON в модель 
 @param json - JSON, который парсится в модель
 @return массив моделей
 */
+ (NSArray *)jsonToModel:(NSDictionary *)json;

@end
