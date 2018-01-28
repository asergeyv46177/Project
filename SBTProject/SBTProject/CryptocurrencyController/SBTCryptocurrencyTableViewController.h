//
//  SBTCryptocurrencyTableViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataService;
@class SBTDownloadDataService;


@interface SBTCryptocurrencyTableViewController : UITableViewController


- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService
                    downloadDataService:(SBTDownloadDataService *)downloadDataService;


@end
