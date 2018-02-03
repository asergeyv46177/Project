//
//  UIImageView+SBTImageView.h
//  SBTProject
//
//  Created by Sergey Altukhov on 02.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Категория класса UIImageView
 */
@interface UIImageView (SBTImageView)

/**
 Создает анимацию при первой загрузке приложения
 @param superview - вью, на которой будет располагаться image view
 @return image view с анимацией
 */
+ (UIImageView *)sbt_animationOnView:(UIView *)superview;

@end
