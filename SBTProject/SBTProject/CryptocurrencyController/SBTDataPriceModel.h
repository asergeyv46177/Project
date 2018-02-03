//
//  SBTDataPriceModel.h
//  SBTProject
//
//  Created by Sergey Altukhov on 20.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 Модель для работы с данными о курсе криптовалют
 */
@interface SBTDataPriceModel : NSObject

@property (nonatomic, copy) NSString *nameString;               /**< Название криптовалюты */
@property (nonatomic, copy) NSString *symbolString;             /**< Символ криптовалюты */
@property (nonatomic, assign) CGFloat priceUSDFloat;            /**< Текущая цена криптовалюты */
@property (nonatomic, assign) CGFloat percentChange24hFloat;    /**< Процент изменения цены криптовалюты за 24 часа */
@property (nonatomic, assign) CGFloat percentChange7dFloat;     /**< Процент изменения цены криптовалюты за неделю */

@end
