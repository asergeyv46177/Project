//
//  SBTPersistentContainer.h
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


/**
 Класс для инициализации core data
 */
@interface SBTPersistentContainer : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;    /**< Контейнер для работы с core data */

@end
