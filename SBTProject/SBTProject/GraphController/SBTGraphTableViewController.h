//
//  SBTGraphTableViewController.h
//  SBTProject
//
//  Created by Сергей Алтухов on 09.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataDownloadFacade;


/**
 Контроллер для отображения таблицы с упрощенными графиками
 */
@interface SBTGraphTableViewController : UITableViewController

/**
 Инициализирует контроллер с фасадом для построения подробного графика
 @param coreDataDownloadFacade - экземпляр класса SBTCoreDataDownloadFacade
 @return экземпляр класса SBTGraphTableViewController
 */
- (instancetype)initWithCoreDataDowloadFacade:(SBTCoreDataDownloadFacade *)coreDataDownloadFacade;

@end
