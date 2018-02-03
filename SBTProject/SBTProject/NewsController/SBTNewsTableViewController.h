//
//  SBTNewsTableViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDownloadDataService;


/**
 Контроллер для отображения таблицы с новостями
 */
@interface SBTNewsTableViewController : UITableViewController

/**
 Инициализирует контроллер с сервисом download data
 @param downloadDataService - экземпляр класса SBTDownloadDataService
 @return экземпляр класса SBTNewsTableViewController
 */
- (instancetype)initWithDownloadDataService:(SBTDownloadDataService *)downloadDataService;

@end
