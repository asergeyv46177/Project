//
//  SBTCoreDataDownloadFacade.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCoreDataDownloadFacade.h"
#import "SBTCoreDataService.h"
#import "SBTDownloadDataService.h"
#import "GraphModel+CoreDataProperties.h"
#import "SBTDataGraphModel.h"


@interface SBTCoreDataDownloadFacade ()

@property (nonatomic, strong) SBTCoreDataService *coreDataService;
@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;

@end


@implementation SBTCoreDataDownloadFacade

- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService
                     dowloadDataService:(SBTDownloadDataService *)downloadDataService;
{
    self = [super init];
    if (self)
    {
        _coreDataService = coreDataService;
        _downloadDataService = downloadDataService;
    }
    return self;
}

- (void)obtainModelGraphWithPredicateString:(NSString *)predicate
            completeHandler:(void(^)(SBTDataGraphModel *dataModel))completeHandler
{
    NSArray <GraphModel *> *modelArray = [self.coreDataService obtainModelArrayWithEntityName:[GraphModel class] predicateString:predicate];
    BOOL isRelevant = [self.coreDataService relevantGraphModel:[modelArray firstObject].dateLastUpdateString];
    if (isRelevant)
    {
        SBTDataGraphModel *dataModel = [[SBTDataGraphModel alloc] initWithGraphModel:modelArray.firstObject];
        completeHandler(dataModel);
    }
    else
    {
        [self.downloadDataService downloadDataWithURLKeyString:predicate downloadDataType:SBTDownloadDataTypeGraph queue:nil
            completeHandler:^(id dataModel){
                [self.coreDataService removeFromCoreData:modelArray.firstObject];
                [self.coreDataService saveGraphModel:dataModel];
                completeHandler(dataModel);
            }];
    }
}

@end
