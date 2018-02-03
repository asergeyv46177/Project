//
//  SBTDataPreparerTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 30.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Ячейка таблицы с описанием возможностей приложения
 */
@interface SBTDataPreparerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;   /**< Иконка кнопки из TabBar */
@property (nonatomic, strong) UILabel *contentLabel;        /**< Описание возможностей приложеня при нажатии данной кнопки на TabBar */

@end
