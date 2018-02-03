//
//  SBTBuilderURLPrice.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Класс для построения URL
 */
@interface SBTBuilderURLPrice : NSObject

/**
 Обеспечивает создание URL
 @param nameString - строка, в которой содержится название криптовалюты
 @return необходимый URL
 */
+ (NSURL *)urlWithNameCryptoString:(NSString *)nameString;

@end
