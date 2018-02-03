//
//  UIView+SBTView.h
//  SBTProject
//
//  Created by Sergey Altukhov on 02.02.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Категория класса UIView
 */
@interface UIView (SBTView)

/**
 Обеспечивает анимированное появление/исчезновение вью
 @param view - вью, к которой применяется анимация
 @param isAppear - логический тип, который определяет появление/исчезновение вью
 @param completion - блок, который выполняется по окончании анимации
 */
+ (void)sbt_animationWithView:(UIView *)view isAppear:(BOOL)isAppear completion:(void(^)(void))completion;

@end
