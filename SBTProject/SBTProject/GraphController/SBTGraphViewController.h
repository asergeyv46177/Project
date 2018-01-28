//
//  SBTGraphViewController.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataDownloadFacade;


@interface SBTGraphViewController : UIViewController


- (instancetype)initWithCoreDateService:(SBTCoreDataDownloadFacade *)coreDataDownloadFacade nameGraph:(NSString *)nameGraphString;


@end
