//
//  SBTDataDescriptionModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 27.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Модель для работы с подробной информации о криптовалюте
 */
@interface SBTDataDescriptionModel : NSObject

@property (nonatomic, copy) NSString *nameString;               /**< Имя криптовалюты */
@property (nonatomic, copy) NSString *symbolString;             /**< Символ криптовалюты */
@property (nonatomic, copy) NSString *startDateString;          /**< Дата появления криптовалюты */
@property (nonatomic, copy) NSString *idString;                 /**< id криптовалюты */
@property (nonatomic, copy) NSString *algorithmString;          /**< Алгоритм майнинга */
@property (nonatomic, copy) NSString *blockRewardString;        /**< Награда за блок */
@property (nonatomic, copy) NSString *blockTimeString;          /**< Время блокировки */
@property (nonatomic, copy) NSString *affiliateUrlString;       /**< Официальный сайт криптовалюты */
@property (nonatomic, copy) NSString *twitterString;            /**< Twitter криптовалюты */
@property (nonatomic, copy) NSString *totalCoinSupplyString;    /**< Общая сумма монет */

@end
