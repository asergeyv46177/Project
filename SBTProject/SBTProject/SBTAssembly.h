//
//  SBTAssembly.h
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "SBTChangeRootViewControllerProtocol.h"

@interface SBTAssembly : NSObject <SBTChangeRootViewControllerProtocol>


- (instancetype)initWithContext:(NSManagedObjectContext *) context;
- (UITabBarController *)createRootViewController;


@end
