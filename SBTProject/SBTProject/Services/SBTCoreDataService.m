//
//  SBTCoreDataService.m
//  SBTProject
//
//  Created by Sergey Altukhov on 23.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCoreDataService.h"
#import "NSDate+SBTDate.h"

#import "GraphModel+CoreDataProperties.h"
#import "DescriptionModel+CoreDataProperties.h"

#import "SBTDataGraphModel.h"
#import "SBTDataDescriptionModel.h"


@interface SBTCoreDataService ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end


@implementation SBTCoreDataService

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self)
    {
        _context = context;
    }
    return self;
}

- (NSArray *)obtainModelArrayWithEntityName:(Class)className predicateString:(NSString *)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(className)];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"nameString == %@", predicate];
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (BOOL)relevantGraphModel:(NSString *)dateLastUpdate
{
    if (!dateLastUpdate)
    {
        return NO;
    }
    NSTimeInterval nowTime = [NSDate new].timeIntervalSince1970;
    NSString *nowTimeString = [NSDate sbt_formatterDateStringWithTimeInterval:nowTime];
    if (![nowTimeString isEqualToString:dateLastUpdate])
    {
        return NO;
    }
    return YES;
}

- (void)saveDescriptionModel:(NSArray <SBTDataDescriptionModel *> *)dataDescriptionModelArray
{
    if (!dataDescriptionModelArray)
    {
        return;
    }
    for (SBTDataDescriptionModel *dataDescriptionModel in dataDescriptionModelArray)
    {
        DescriptionModel *descriptionModel = [NSEntityDescription
            insertNewObjectForEntityForName:NSStringFromClass([DescriptionModel class]) inManagedObjectContext:self.context];
        NSString *str = dataDescriptionModel.nameString;
        descriptionModel.nameString = str;
        descriptionModel.symbolString = dataDescriptionModel.symbolString;
        descriptionModel.startDateString = dataDescriptionModel.startDateString;
        descriptionModel.idString = dataDescriptionModel.idString;
        descriptionModel.algorithmString = dataDescriptionModel.algorithmString;
        descriptionModel.blockTimeString = dataDescriptionModel.blockTimeString;
        descriptionModel.blockRewardString = dataDescriptionModel.blockRewardString;
        descriptionModel.affiliateUrlString = dataDescriptionModel.affiliateUrlString;
        descriptionModel.twitterString = dataDescriptionModel.twitterString;
        descriptionModel.totalCoinSupplyString = dataDescriptionModel.totalCoinSupplyString;
        [self.context save:nil];
    }
}

- (void)saveGraphModel:(SBTDataGraphModel *)dataGraphModel
{
    if (!dataGraphModel)
    {
        return;
    }
    GraphModel *graphModel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([GraphModel class])
        inManagedObjectContext:self.context];
    graphModel.nameString = dataGraphModel.nameString;
    graphModel.descriptionString = dataGraphModel.descriptionString;
    graphModel.unitString = dataGraphModel.unitString;
    graphModel.valuesXYArray = dataGraphModel.valuesXYArray;
    graphModel.maxYInteger = dataGraphModel.maxYInteger;
    graphModel.dateLastUpdateString = dataGraphModel.dateLastUpdateString;
    [self.context save:nil];
}

- (void)removeFromCoreData:(NSManagedObject *)entity
{
    if (!entity)
    {
        return;
    }
    [self.context deleteObject:entity];
    [self.context save:nil];
}

@end
