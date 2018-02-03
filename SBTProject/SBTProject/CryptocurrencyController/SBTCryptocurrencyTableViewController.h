//
//  SBTCryptocurrencyTableViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataService;
@class SBTDownloadDataService;


/**
 Контроллер для отображения таблицы с текущей ценой криптовалюты в USD
 */
@interface SBTCryptocurrencyTableViewController : UITableViewController

/**
 Инициализирует контроллер с сервисами download data и core data
 @param coreDataService - экземпляр класса SBTCoreDataService
 @param downloadDataService - экземпляр класса SBTDownloadDataService
 @return экземпляр класса SBTCryptocurrencyTableViewController
 */
- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService
                    downloadDataService:(SBTDownloadDataService *)downloadDataService;

@end
