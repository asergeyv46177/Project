//
//  SBTParsingJSONDescription.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBTDataDescriptionModel;


@interface SBTParsingJSONDescription : NSObject


+ (NSArray *)jsonToModel:(NSDictionary *)json;


@end
