//
//  SBTGraphViewController.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class SBTDataGraphModel;
@class SBTCoreDataService;


@interface SBTGraphViewController : UIViewController


- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService nameGraph:(NSString *)nameGraphString;


@end
