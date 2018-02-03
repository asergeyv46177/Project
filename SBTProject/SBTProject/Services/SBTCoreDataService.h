//
//  SBTCoreDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 23.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class SBTDataGraphModel;


/**
 Сервис для работы с core data
 */
@interface SBTCoreDataService : NSObject

/**
 Инициализирует сервис с контекстом
 @param context - контекст для настрокий сервиса
 @return экземпляр класса SBTCoreDataService
 */
- (instancetype)initWithContext:(NSManagedObjectContext *)context;

/**
 Обеспечивает получение массива сущностей из core data
 @param className - имя класса сущности
 @param predicate - строка, по которой создается запрос на получение сущностей из core data
 @return массив сущностей
 */
- (NSArray *)obtainModelArrayWithEntityName:(Class)className predicateString:(NSString *)predicate;

/**
 Определение релевантности данных
 @param dateLastUpdate - строка, в которой содержится дата последнего обновления данных
 @return логический тип
 */
- (BOOL)relevantGraphModel:(NSString *)dateLastUpdate;

/**
 Сохранение модели в core data
 @param dataGraphModel - модель, котороя сохраняется
 */
- (void)saveGraphModel:(SBTDataGraphModel *)dataGraphModel;

/**
 Сохранение данных в core data
 @param dataDescriptionModelArray - модель, котороя сохраняется
 */
- (void)saveDescriptionModel:(NSArray *)dataDescriptionModelArray;

/**
 Удаление данных из core data
 @param entity - сущность, которая удаляется
 */
- (void)removeFromCoreData:(NSManagedObject *)entity;

@end
