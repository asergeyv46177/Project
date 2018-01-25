//
//  SBTPersistentContainer.h
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SBTPersistentContainer : NSObject


@property (readonly, strong) NSPersistentContainer *persistentContainer;


@end
