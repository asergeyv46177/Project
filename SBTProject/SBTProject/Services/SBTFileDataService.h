//
//  SBTFileDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Сервис для работы с файлами
 */
@interface SBTFileDataService : NSObject

/**
 Обеспечивает получение массива данных из файлов
 @param pathForResource - имя файла
 @param type - расширение файла
 @return массив данных
 */
+ (NSArray *)obtainJSONWithPathForResource:(NSString *)pathForResource ofType:(NSString *)type;

@end
