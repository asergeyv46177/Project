//
//  SBTDataNewsModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 31.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Модель для работы с данными о новостях
 */
@interface SBTDataNewsModel : NSObject

@property (nonatomic, copy) NSString *dateString;           /**< Дата публикации новости */
@property (nonatomic, copy) NSString *titleString;          /**< Заголовок новости */
@property (nonatomic, copy) NSString *descriptionString;    /**< Содержание новости */
@property (nonatomic, copy) NSString *authorString;         /**< Автор новости */
@property (nonatomic, copy) NSString *urlString;            /**< URL первоисточника новости */

@end
