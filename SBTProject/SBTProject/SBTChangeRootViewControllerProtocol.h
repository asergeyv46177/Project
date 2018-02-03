//
//  SBTChangeRootViewControllerProtocol.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Протокол для замены корневого контроллера
 */
@protocol SBTChangeRootViewControllerProtocol <NSObject>

/**
 Осуществляет замену корневого контроллера
 @param oldViewController - контроллер, который подвергается замене
 */
- (void)changeRootViewController:(UIViewController *)oldViewController;

@end
