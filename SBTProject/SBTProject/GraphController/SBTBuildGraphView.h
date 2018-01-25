//
//  SBTBuildGraphView.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphModel+CoreDataProperties.h"
@class SBTCoreDataService;

@interface SBTBuildGraphView : UIView


- (instancetype)initWithCoreDateService:(SBTCoreDataService *)coreDataService objectID:(NSManagedObjectID *)objectID
        withView:(UIView *)yAxisValuesView;


@end
