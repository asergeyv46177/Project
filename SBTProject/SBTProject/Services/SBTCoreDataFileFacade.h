//
//  SBTCoreDataFileFacade.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTCoreDataService;


/**
 Класс для организации взаимодействия между сервисами core data и file data
 */
@interface SBTCoreDataFileFacade : NSObject

/**
 Инициализирует класс с сервисом core data
 @param coreDataService - экземпляр класса SBTCoreDataService
 @return экземпляр класса SBTCoreDataFileFacade
 */
- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService;

/**
 Осуществляет подготовку core data для использования в SBTCryptocurrencyDescriptionView
 */
- (void)prepareData;

@end
