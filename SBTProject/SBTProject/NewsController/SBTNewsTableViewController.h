//
//  SBTNewsTableViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDownloadDataService;

@interface SBTNewsTableViewController : UITableViewController


- (instancetype)initWithDownloadDataService:(SBTDownloadDataService *)downloadDataService;


@end
