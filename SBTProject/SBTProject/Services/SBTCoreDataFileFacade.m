//
//  SBTCoreDataFileFacade.m
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTCoreDataFileFacade.h"
#import "SBTCoreDataService.h"
#import "SBTFileDataService.h"


@interface SBTCoreDataFileFacade ()


@property (nonatomic, strong) SBTCoreDataService *coreDataService;


@end


@implementation SBTCoreDataFileFacade


- (instancetype)initWithCoreDataService:(SBTCoreDataService *)coreDataService
{
    self = [super init];
    if (self)
    {
        _coreDataService = coreDataService;
    }
    return self;
}

- (void)prepareData
{
    NSArray *arrayModel = [SBTFileDataService obtainJSONWithPathForResource:@"cryptoJSON" ofType:@"json"];
    [self.coreDataService saveDescriptionModel:arrayModel];
}


@end
