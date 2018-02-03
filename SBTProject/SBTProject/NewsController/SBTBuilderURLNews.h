//
//  SBTBuilderURLNews.h
//  SBTProject
//
//  Created by Sergey Altukhov on 01.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Класс для построения URL
 */
@interface SBTBuilderURLNews : NSObject

/**
 Обеспечивает создание URL
 @param pageSize - строка, в которой содержится число новостей
 @return необходимый URL
 */
+ (NSURL *)urlWithPageSize:(NSString *)pageSize;

@end
