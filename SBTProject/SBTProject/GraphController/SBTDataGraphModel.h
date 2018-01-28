//
//  SBTDataGraphModel.h
//  SBTProject
//
//  Created by Сергей Алтухов on 10.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GraphModel;


@interface SBTDataGraphModel : NSObject


@property (nonatomic, copy) NSString *unitString;
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSArray *valuesXYArray;
@property (nonatomic, copy) NSString *dateLastUpdateString;
@property (nonatomic, assign) NSInteger maxYInteger;

- (instancetype)initWithGraphModel:(GraphModel *)graphModel;


@end
