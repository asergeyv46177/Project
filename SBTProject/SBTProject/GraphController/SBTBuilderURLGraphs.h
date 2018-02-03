//
//  SBTBuilderURLGraphs.h
//  SBTProject
//
//  Created by Sergey Altukhov on 19.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Класс для построения URL
 */
@interface SBTBuilderURLGraphs : NSObject

/**
 Обеспечивает создание URL
 @param nameString - строка, в которой содержится название графика
 @return необходимый URL
 */
+ (NSURL *)urlWithNameGraph:(NSString *)nameString;

@end
