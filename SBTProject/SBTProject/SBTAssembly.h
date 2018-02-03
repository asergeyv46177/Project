//
//  SBTAssembly.h
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SBTChangeRootViewControllerProtocol.h"


/**
 Класс для настройки корневого контроллера
 */
@interface SBTAssembly : UIView <SBTChangeRootViewControllerProtocol>

/**
 Инициализирует класс с контекстом
 @param context - контекст для настрокий сервиса core data
 @return экземпляр класса SBTAssembly
 */
- (instancetype)initWithContext:(NSManagedObjectContext *)context;

/**
 Обеспечивает создание корневого контроллера
 @return экземпляр класса UIViewController
 */
- (UIViewController *)createRootViewController;

@end
