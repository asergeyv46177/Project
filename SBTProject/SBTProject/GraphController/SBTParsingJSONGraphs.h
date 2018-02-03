//
//  SBTParsingJSONGraphs.h
//  SBTProject
//
//  Created by Sergey Altukhov on 18.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataGraphModel;


/**
 Класс для получения модели SBTDataGraphModel из JSON
 */
@interface SBTParsingJSONGraphs : NSObject

/**
 Обеспечивает парсинг JSON в модель
 @param json - JSON, который парсится в модель
 @return необходимая модель
 */
+ (SBTDataGraphModel *)jsonToModel:(NSDictionary *)json;

@end
