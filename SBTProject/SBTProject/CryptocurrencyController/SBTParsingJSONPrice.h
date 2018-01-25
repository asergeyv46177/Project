//
//  SBTParsingJSONPrice.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBTDataPriceModel.h"

@interface SBTParsingJSONPrice : NSObject


+ (SBTDataPriceModel *)jsonToModel:(NSDictionary *)json;


@end
