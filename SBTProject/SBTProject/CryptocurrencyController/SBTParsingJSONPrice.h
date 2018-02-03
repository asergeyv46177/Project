//
//  SBTParsingJSONPrice.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataPriceModel;


/**
 Класс для получения модели SBTDataPriceModel из JSON
 */
@interface SBTParsingJSONPrice : NSObject

/**
 Обеспечивает парсинг JSON в модель
 @param json - JSON, который парсится в модель
 @return необходимая модель
 */
+ (SBTDataPriceModel *)jsonToModel:(NSDictionary *)json;

@end
