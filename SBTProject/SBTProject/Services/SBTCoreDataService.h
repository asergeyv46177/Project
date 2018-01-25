//
//  SBTCoreDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 23.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SBTCoreDataService : NSObject


@property (nonatomic, strong) NSManagedObjectContext *context;

typedef NS_ENUM(NSUInteger, SBTCoreDataType) {
    SBTCoreDataTypeGraph,
    SBTCoreDataTypeCrypto,
};

- (instancetype)initWithContext:(NSManagedObjectContext *)context session:(NSURLSession *)session;

- (NSArray *)obtainModelArrayWithEntityName:(Class)class predicateString:(NSString *)predicateString;
- (void)modelGraphWithEntityName:(Class)class predicateString:(NSString *)predicateString coreDataType:(SBTCoreDataType)coreDataType
            completeHandler:(void(^)(NSManagedObjectID *))completeHandler;


@end
