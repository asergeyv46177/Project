//
//  SBTDownloadDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SBTDownloadDataService : NSObject


typedef NS_ENUM(NSUInteger, SBTDownloadDataType) {
    SBTDownloadDataTypeGraph,
    SBTDownloadDataTypePrice,
    SBTDownloadDataTypeNews,
};

- (void)downloadDataWithURLKeyString:(NSString *)urlKey downloadDataType:(SBTDownloadDataType)dataType queue:(dispatch_queue_t)queue
            completeHandler:(void(^)(id))completeHandler;
- (void)downloadGroupWithURLKeyArray:(NSArray *)urlKeyArray downloadDataType:(SBTDownloadDataType)dataType
            completeHandler:(void(^)(NSArray *))completeHandler;


@end
