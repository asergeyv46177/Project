//
//  SBTDownloadDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Сервис для работы с сетью
 */
@interface SBTDownloadDataService : NSObject

/**
 Enum для определения, как должен быть создан URL и как необходимо парсить полученные данные из сети
 */
typedef NS_ENUM(NSUInteger, SBTDownloadDataType) {
    SBTDownloadDataTypeGraph = 1,
    SBTDownloadDataTypePrice,
    SBTDownloadDataTypeNews,
};

/**
 Обеспечивает получение данных из сети
 @param urlKey - строка, по которой создается URL
 @param dataType - постоянная из SBTDownloadDataType
 @param queue - очередь, на которой должен быть выполнен completeHandler
 @param completeHandler - блок, который выполняется по окончании загрузки
 */
- (void)downloadDataWithURLKeyString:(NSString *)urlKey downloadDataType:(SBTDownloadDataType)dataType queue:(dispatch_queue_t)queue
            completeHandler:(void(^)(id))completeHandler;

/**
 Обеспечивает получение массива данных из сети
 @param urlKeyArray - массив, в котором содержатся строки, по которым создаются URL
 @param dataType - постоянная из SBTDownloadDataType
 @param completeHandler - блок, который выполняется по окончании загрузки
 */
- (void)downloadGroupWithURLKeyArray:(NSArray *)urlKeyArray downloadDataType:(SBTDownloadDataType)dataType
            completeHandler:(void(^)(NSArray *))completeHandler;

@end
