//
//  SBTDataPreparerViewController.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTCoreDataFileFacade;
@protocol SBTChangeRootViewControllerProtocol;

@interface SBTDataPreparerViewController : UIViewController


- (instancetype)initWithCoreDataFileFacade:(SBTCoreDataFileFacade *)coreDataFileFacade;

@property (nonatomic, weak) id <SBTChangeRootViewControllerProtocol> delegate;


@end
