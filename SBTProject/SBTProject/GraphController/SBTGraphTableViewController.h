//
//  SBTGraphTableViewController.h
//  SBTProject
//
//  Created by Сергей Алтухов on 09.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataDownloadFacade;


@interface SBTGraphTableViewController : UITableViewController


- (instancetype)initWithCoreDataDowloadFacade:(SBTCoreDataDownloadFacade *)coreDataDowloadFacade;


@end
