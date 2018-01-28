//
//  SBTCoreDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 23.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class SBTDataGraphModel;


@interface SBTCoreDataService : NSObject


- (instancetype)initWithContext:(NSManagedObjectContext *)context;

- (NSArray *)obtainModelArrayWithEntityName:(Class)class predicateString:(NSString *)predicate;
- (BOOL)relevantGraphModel:(NSString *)dateLastUpdate;
- (void)saveGraphModel:(SBTDataGraphModel *)dataGraphModel;
- (void)saveDescriptionModel:(NSArray *)dataDescriptionModelArray;
- (void)removeFromCoreData:(NSManagedObject *)entity;


#pragma mark - Remove!
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
