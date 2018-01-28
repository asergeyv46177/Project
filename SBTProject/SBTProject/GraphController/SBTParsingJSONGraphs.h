//
//  SBTParsingJSONGraphs.h
//  SBTProject
//
//  Created by Sergey Altukhov on 18.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataGraphModel;


@interface SBTParsingJSONGraphs : NSObject


+ (SBTDataGraphModel *)jsonToModel:(NSDictionary *)json;


@end
