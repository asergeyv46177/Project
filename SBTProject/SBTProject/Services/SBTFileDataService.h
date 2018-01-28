//
//  SBTFileDataService.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SBTFileDataService : NSObject


+ (NSArray *)obtainJSONWithPathForResource:(NSString *)pathForResource ofType:(NSString *)type;


@end
