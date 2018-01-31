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


@property (nonatomic, strong) SBTDownloadDataService *downloadDataService;
@property (nonatomic, strong) SBTCoreDataService *coreDataService;


@end



@implementation SBTCoreDataDownloadFacade


- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService
                     dowloadDataService:(SBTDownloadDataService *)downloadDataService;
{
    self = [super init];
    if (self)
    {
        _downloadDataService = downloadDataService;
        _coreDataService = coreDataService;
    }
    return self;
}

- (void)obtainModelGraphWithPredicateString:(NSString *)predicate
            completeHandler:(void(^)(SBTDataGraphModel *))completeHandler
{
    NSArray <GraphModel *> *modelArray = [self.coreDataService obtainModelArrayWithEntityName:[GraphModel class]
                                            predicateString:predicate];
    
    BOOL isRelevant = [self.coreDataService relevantGraphModel:[modelArray firstObject].dateLastUpdateString];
    
    if (isRelevant)
    {
        SBTDataGraphModel *dataGraphModel = [[SBTDataGraphModel alloc] initWithGraphModel:modelArray.firstObject];
        completeHandler(dataGraphModel);
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
