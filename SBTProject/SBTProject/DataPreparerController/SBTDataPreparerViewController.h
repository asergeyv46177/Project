//
//  SBTDataPreparerViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataFileFacade;
@protocol SBTChangeRootViewControllerProtocol;


/**
 Контроллер для подготовки данных core data и отображения описания приложения
 */
@interface SBTDataPreparerViewController : UIViewController

/**
 Инициализирует контроллер с фасадом для работы с сервисами core data и file data
 @param coreDataFileFacade - экземпляр класса SBTCoreDataFileFacade
 @return экземпляр класса SBTDataPreparerViewController
 */
- (instancetype)initWithCoreDataFileFacade:(SBTCoreDataFileFacade *)coreDataFileFacade;

@property (nonatomic, weak) id <SBTChangeRootViewControllerProtocol> delegate;  /**< Делегат контроллера, реализующий
    протокол  SBTChangeRootViewControllerProtocol */

@end
