//
//  SBTCoreDataDownloadFacade.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDownloadDataService;
@class SBTCoreDataService;
@class SBTDataGraphModel;


/**
 Класс для организации взаимодействия между сервисами core data и download data
 */
@interface SBTCoreDataDownloadFacade : NSObject

/**
 Инициализирует класс с сервисами core data и download data
 @param coreDataService - экземпляр класса SBTCoreDataService
 @param downloadDataService - экземпляр класса SBTDownloadDataService
 @return экземпляр класса SBTCoreDataDownloadFacade
 */
- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService
                     dowloadDataService:(SBTDownloadDataService *)downloadDataService;

/**
 Обеспечивает получение модели SBTDataGraphModel
 @param predicate - строка, по которой создается запрос на получение данных из core data или сети
 @param completeHandler - блок, который выполняется по окончании метода
 block parameters:
 dataModel - запрашиваемая модель данных
 */
- (void)obtainModelGraphWithPredicateString:(NSString *)predicate
            completeHandler:(void(^)(SBTDataGraphModel *dataModel))completeHandler;

@end
