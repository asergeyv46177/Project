//
//  SBTNewsTableViewCell.h
//  SBTProject
//
//  Created by Sergey Altukhov on 17.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBTDataNewsModel;


/**
 Ячейка таблицы с новостями 
 */
@interface SBTNewsTableViewCell : UITableViewCell

/**
 Обеспечивает заполнение ячейки данными
 @param newsModel - модель, из которой берутся данные для заполнения
 */
- (void)setupContentCell:(SBTDataNewsModel *)newsModel;

@end
