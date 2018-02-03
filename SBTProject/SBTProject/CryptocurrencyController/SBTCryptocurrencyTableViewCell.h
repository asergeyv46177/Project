//
//  SBTCryptocurrencyTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 11.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDataPriceModel;


/**
 Ячейка таблицы с текущими ценами на криптовалюту 
 */
@interface SBTCryptocurrencyTableViewCell : UITableViewCell

/**
 Обеспечивает заполнение ячейки данными
 @param priceModel - модель, из которой берутся данные для заполнения
 */
- (void)setupContentCell:(SBTDataPriceModel *)priceModel;

@end
