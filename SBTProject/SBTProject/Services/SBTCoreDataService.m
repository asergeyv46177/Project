//
//  SBTCoreDataService.m
//  SBTProject
//
//  Created by Sergey Altukhov on 23.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCoreDataService.h"
#import "SBTDownloadDataService.h"
#import "GraphModel+CoreDataProperties.h"
#import "SBTDataGraphModel.h"



@interface SBTCoreDataService ()


typedef NS_ENUM(NSUInteger, SBTCoreDataState) {
    SBTCoreDataStateRelevant,
    SBTCoreDataStateNotRelevant,
};

@property (nonatomic, strong) NSURLSession *session;


@end


@implementation SBTCoreDataService


- (instancetype)initWithContext:(NSManagedObjectContext *)context session:(NSURLSession *)session;
{
    self = [super init];
    if (self)
    {
        _context = context;
        _session = session;
    }
    return self;
}

- (NSArray *)obtainModelArrayWithEntityName:(Class)class predicateString:(NSString *)predicateString
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(class)];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"nameString == %@", predicateString];
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (void)modelPriceWithEntityName:(Class)class predicateString:(NSString *)predicateString coreDataType:(SBTCoreDataType)coreDataType
            completeHandler:(void(^)(NSManagedObjectID *))completeHandler;
{
    
}


- (void)modelGraphWithEntityName:(Class)class predicateString:(NSString *)predicateString coreDataType:(SBTCoreDataType)coreDataType
            completeHandler:(void(^)(NSManagedObjectID *))completeHandler
{
    NSArray <GraphModel *> *modelArray = [self obtainModelArrayWithEntityName:[GraphModel class] predicateString:predicateString];
    SBTCoreDataState coreDataState = [self relevantGraphModel:[modelArray firstObject].dateLastUpdateString];
    switch (coreDataState) {
        case SBTCoreDataStateNotRelevant:
        {
            NSLog(@"CoreDataStateNotRelevant Download");
            [SBTDownloadDataService downloadDataWithURLSession:self.session urlKeyString:predicateString
                dataType:SBTDownloadDataTypeGraph completeHandler:^(id dataModel) {
                    if (!dataModel)
                    {
                        return;
                    }
                    [self removeFromCoreData:[modelArray firstObject]];
                    [self saveGraphModel:dataModel];
                    NSArray <GraphModel *> *newModelArray = [self obtainModelArrayWithEntityName:class predicateString:predicateString];
                    NSManagedObjectID *objectID = [newModelArray firstObject].objectID;
                    completeHandler(objectID);
                }];
            break;
        }
        case SBTCoreDataStateRelevant:
        {
            NSLog(@"CoreDataStateRelevant");
            completeHandler([modelArray firstObject].objectID);
            break;
        }
    }
}

- (SBTCoreDataState)relevantGraphModel:(NSString *)dateLastUpdate
{
    if (!dateLastUpdate)
    {
        return SBTCoreDataStateNotRelevant;
    }

    NSTimeInterval nowTime = [NSDate new].timeIntervalSince1970;
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:nowTime];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MMM,d"];
    NSString *nowTimeString = [dateFormatter stringFromDate:date];
    if (![nowTimeString isEqualToString:dateLastUpdate])
    {
        return SBTCoreDataStateNotRelevant;
    }

    return SBTCoreDataStateRelevant;
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
