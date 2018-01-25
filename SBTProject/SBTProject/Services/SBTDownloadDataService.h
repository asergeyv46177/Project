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

+ (void)downloadDataWithURLSession:(NSURLSession *)session urlKeyString:(NSString *)urlKey
            dataType:(SBTDownloadDataType)dataType completeHandler:(void(^)(id))completeHandler;


@end
