//
//  SBTCoreDataDownloadFacade.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDownloadDataService;
@class SBTCoreDataService;
@class SBTDataGraphModel;


@interface SBTCoreDataDownloadFacade : NSObject


- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService
                     dowloadDataService:(SBTDownloadDataService *)downloadDataService;

- (void)obtainModelGraphWithPredicateString:(NSString *)predicate
            completeHandler:(void(^)(SBTDataGraphModel *))completeHandler;


@end
