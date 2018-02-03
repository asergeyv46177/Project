//
//  SBTCryptocurrencyDescriptionView.h
//  SBTProject
//
//  Created by Sergey Altukhov on 12.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DescriptionModel;


/**
 Вью, на которой отображается описание криптовалюты в виде таблицы
 */
@interface SBTCryptocurrencyDescriptionView : UIView

/**
 Инициализирует вью с супервью и моделью
 @param superview - супервью, на которую будет добавлена вью
 @param descriptionModel - модель с контентом, который содержится во вью
 @return экземпляр класса SBTCryptocurrencyDescriptionView
 */
- (instancetype)initWithSuperview:(UIView *)superview descriptionModel:(DescriptionModel *)descriptionModel;

@end
