//
//  SBTGraphTableViewCell.h
//  SBTProject
//
//  Created by Сергей Алтухов on 09.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Ячейка таблицы с названием и упрощенным видом графика 
 */
@interface SBTGraphTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameGraphLabel;              /**< Название графика */
@property (nonatomic, strong) UIImageView *viewGraphImageView;      /**< Картинка с упрощенным видом графика */

@end
