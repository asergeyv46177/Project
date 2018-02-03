//
//  SBTCryptocurrencyDescriptionTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 16.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Ячейка таблицы с описанием криптовалюты
 */
@interface SBTCryptocurrencyDescriptionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameDescriptionLabel;        /**< Название параметра */
@property (nonatomic, strong) UILabel *contentDescriptionLabel;     /**< Значение параметра */

/**
 Обеспечивает заполнение ячейки данными
 @param row - номер ячейки в таблице
 @param content - контент для заполнения ячейки
 */
- (void)setupContentCellWithIndexRow:(NSInteger)row content:(NSArray *)content;

@end
