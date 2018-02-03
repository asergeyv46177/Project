//
//  SBTGraphViewController.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataDownloadFacade;


/**
 Контроллер для отображения подробного графика с названием и описанием
 */
@interface SBTGraphViewController : UIViewController

/**
 Инициализирует контроллер с фасадом для работы с сервисами core data и download data
 @param coreDataDownloadFacade - экземпляр класса SBTCoreDataDownloadFacade
 @return экземпляр класса SBTGraphViewController
 */
- (instancetype)initWithCoreDateService:(SBTCoreDataDownloadFacade *)coreDataDownloadFacade nameGraph:(NSString *)nameGraphString;

@end
